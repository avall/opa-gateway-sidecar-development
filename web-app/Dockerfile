FROM adoptopenjdk:14-jre-openj9-focal
ARG MAINTAINER="Pratim Chaudhuri <pratim@chaudhuri.me>"
ARG PACKAGE_NAME="microservice-api"
ARG STAGE_DIRECTORY="target/universal/stage"
ARG RESOURCE_DIRECTORY="src/main/resources"
ARG WORK_DIRECTORY="/microservice"
ARG DAEMON_USER="microu"
ARG DAEMON_GROUP="microg"

LABEL maintainer=${MAINTAINER}
COPY ${STAGE_DIRECTORY} ${WORK_DIRECTORY}
COPY ${RESOURCE_DIRECTORY}/* ${WORK_DIRECTORY}/config/
WORKDIR ${WORK_DIRECTORY}

# Install basic investigative tools
RUN apt-get update -y ; apt-get install -y --no-install-recommends inetutils-ping

# Install the Application
RUN groupadd ${DAEMON_GROUP} \
    && useradd -g ${DAEMON_GROUP} ${DAEMON_USER} \
    && mkdir -p ${WORK_DIRECTORY}/data ${WORK_DIRECTORY}/keys ${WORK_DIRECTORY}/logs \
    && chown -R ${DAEMON_USER}:${DAEMON_GROUP} ${WORK_DIRECTORY} \
    && chmod -R 2775 ${WORK_DIRECTORY}
VOLUME /${WORK_DIRECTORY}/config /${WORK_DIRECTORY}/data /${WORK_DIRECTORY}/keys ${WORK_DIRECTORY}/logs
USER ${DAEMON_USER}:${DAEMON_GROUP}

ENTRYPOINT ${WORK_DIRECTORY}/bin/${PACKAGE_NAME}

CMD []
