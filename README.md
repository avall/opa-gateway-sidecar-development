# Authorization using OPA and Gateway Pattern


## Executing the demo app locally

Browse to directory `web-app`. Execute the following command to start the server:
```shell
sbt run
```
The demo app is written in [Scala](https://www.scala-lang.org/). Ensure that you have at least JVM 11 on your machine, and also [`sbt`](https://www.scala-sbt.org/).

The server will start at [`http://localhost:8080`](http://localhost:8080). To change the port number or bind address modify the
values in the file [reference.conf](web-app/src/main/resources/reference.conf).

### Demo api calls

- List of students

```shell
 curl -X GET --location "http://localhost:8080/students" \
    -H "Accept: application/json"
 ```

- Public profile of student `s1`

```shell
curl -X GET --location "http://localhost:8080/students/s1/public-profile" \
    -H "Accept: application/json"
```

- Full profile of student `s1`

```shell
curl -X GET --location "http://localhost:8080/students/s1/profile" \
    -H "Accept: application/json"
```

> Note: The demo app has 4 students with ids `s1`, `s2`, `s3` and `s4`. It has 2 teachers with ids `t1` and `t2`

## 1. Run the app in Kubernetes

Create a separate namespace to install the app in the kubernetes cluster, by executing the below command:
```shell
kubectl create namespace demo-web-app
```

Install the app using helm on the kubernetes cluster, by executing the below command:
```shell
helm upgrade web-app infra/web-app --namespace=demo-web-app --values=infra/web-app/values.yaml --install
```


If you are executing the code in a Kubernetes cluster based on `minikube`, then you can get the url of the secured service by executing the command :
```shell
minikube service  --namespace=demo-web-app --url web-app-http
```

## 2. _Securing_ the app with no code change

Create a separate namespace to install the app in the kubernetes cluster, by executing the below command:
```shell
kubectl create namespace demo-web-app-secured
```

Install the app using helm on the kubernetes cluster, by executing the below command:
```shell
helm upgrade web-app infra/web-app-secured --namespace=demo-web-app-secured --values=infra/web-app-secured/values.yaml --install

```

If you are executing the code in a Kubernetes cluster based on `minikube`, then you can get the url of the secured service by executing the command :
```shell
minikube service  --namespace=demo-web-app-secured --url web-app-http
```

The file at [`api-web-app.http`](test/api-web-app.http) has sample API calls for endpoints of the service. Replace the url in the sample call file, with that of the service in your cluster. 

You will notice that JWT token and roles of the caller is important to access the service endpoint. Thus, the application is now secured, without making any change in the application code. 

This is the `Gateway` and `Side Car` patterns applied to the app for securing it, without making any code changes on the app. This approach allows the bussiness app developer to focus on building app feature, without worrying about code to secure. The code to secure the app is provided by the platform, and in a consistent way across all the apps hosted on the platform. Business, Security, App dev, etc all can come together to define policies. 

For this example, the authorization policies can be seen at Helm template file [`opa-policy.yaml`](infra/web-app-secured/templates/opa-policy.yaml).

## 3. Remote policies

Expanding on `2. Securing the app with no code change`, sometimes we do not want the policies to be part of the application code. The OPA policies in this situation can be compiled as bundle and published for consumption by OPA engine.  OPA has documentation on how the bundle should be created and published at [here](https://www.openpolicyagent.org/docs/latest/management-bundles/).

A separate project under directory [`web-app-authorization`](web-app-authorization) holds the policies applicable for the demo web app. The bundled policies are published using very popular webserver [Apache Webserver](https://hub.docker.com/_/httpd).

Create a separate namespace to install the app in the kubernetes cluster, by executing the below command:
```shell
kubectl create namespace demo-web-app-remote-policy
```

Install the app using helm on the kubernetes cluster, by executing the below command:
```shell
helm upgrade web-app infra/web-app-remote-policy --namespace=demo-web-app-remote-policy --values=infra/web-app-remote-policy/values.yaml --install

```

Here, the OPA policy bundles are served by the service at `service/web-app-opa-policy`.

If you are executing the code in a Kubernetes cluster based on `minikube`, then you can get the url of the secured service by executing the command :
```shell
minikube service  --namespace=demo-web-app-remote-policy --url web-app-http
```
You can update the service url in the test API calls in file [api-web-app.http](test/api-web-app.http), and execute the calls. You will see that same OPA policies/controls are applicable.

This pattern retains the resiliency of the application. You can assert it by executing below commands:
```shell
kubectl -n demo-web-app-remote-policy delete service/web-app-opa-policy
kubectl -n demo-web-app-remote-policy delete deployment.apps/web-app-opa-policy
```
The above commands will delete the service publishing OPA bundle. Now execute the API calls in file [api-web-app.http](test/api-web-app.http), and you will see that web service still responds correctly with the right policies.

Now you can fire the below command again to redeploy the deleted components, simulating deployment of new version of policy. You will notice that the pods of the web application is not deployeed.
```shell
helm upgrade web-app infra/web-app-remote-policy --namespace=demo-web-app-remote-policy --values=infra/web-app-remote-policy/values.yaml --install
```


