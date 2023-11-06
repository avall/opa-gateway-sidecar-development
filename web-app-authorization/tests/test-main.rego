package demo.authz

######################################################
#Test teacher JWT payload
#{
#  "iss": "central-auth-server",
#  "aud": "demo-app",
#  "sub": "amanda@example.com",
#  "roles": [
#    "admin",
#    "teacher",
#    "access.teacher.t1",
#    "access.student.s1",
#    "access.student.s2"
#  ]
#}
######################################################
# JWT Tokens:
##################
# Teacher 1: amanda
# Token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZW50cmFsLWF1dGgtc2VydmVyIiwiYXVkIjoiZGVtby1hcHAiLCJzdWIiOiJhbWFuZGFAZXhhbXBsZS5jb20iLCJyb2xlcyI6WyJhZG1pbiIsInRlYWNoZXIiLCJhY2Nlc3MudGVhY2hlci50MSIsImFjY2Vzcy5zdHVkZW50LnMxIiwiYWNjZXNzLnN0dWRlbnQuczIiXSwianRpIjoiOTk1OTUyZjItMDZiYS00NDhiLTkxYTktMmQ3MTdiNTY2NmI0IiwiaWF0IjoxNjIxMjU3NjgzLCJleHAiOjE2MjEyNjEyODN9.cF3bB5f84WN85XE3a1dEZSoXQl9AO_oawN1xLXw_92Q
##################
# Teacher 2: john
# Token : eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZW50cmFsLWF1dGgtc2VydmVyIiwiYXVkIjoiZGVtby1hcHAiLCJzdWIiOiJqb2huQGV4YW1wbGUuY29tIiwicm9sZXMiOlsidGVhY2hlciIsImFjY2Vzcy50ZWFjaGVyLnQyIiwiYWNjZXNzLnN0dWRlbnQuczMiLCJhY2Nlc3Muc3R1ZGVudC5zNCJdLCJqdGkiOiIwMWMxN2Q3My1jN2VjLTRiMWYtOTgyNi1hODQ2YTc4YTI3MmQiLCJpYXQiOjE2MjEyNTg5NjcsImV4cCI6MTYyMTI2MjU2N30.rt7V7PBsI0-309Kx19VQs3kue5NoTraJOwXUwThyx9I
##################
# Student s1: Amit
# Token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZW50cmFsLWF1dGgtc2VydmVyIiwiYXVkIjoiZGVtby1hcHAiLCJzdWIiOiJzdHVkZW50LmFtaXRAZXhhbXBsZS5jb20iLCJyb2xlcyI6WyJzdHVkZW50IiwiYWNjZXNzLnN0dWRlbnQuczEiXSwianRpIjoiNDY4ZmRmMWItYjZhOS00Y2I1LWIyYjctY2RmMTJjMzMyZjY2IiwiaWF0IjoxNjIxMjU5MDM4LCJleHAiOjE2MjEyNjI2Mzh9.Pfx5lQU5KqMMDTLNFflwNd_p9_I17eMlErmUAk_X4bQ
##################
# Student s2 : Anne-Marie
# Token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZW50cmFsLWF1dGgtc2VydmVyIiwiYXVkIjoiZGVtby1hcHAiLCJzdWIiOiJzdHVkZW50LmFubmUtbWFyaWVAZXhhbXBsZS5jb20iLCJyb2xlcyI6WyJzdHVkZW50IiwiYWNjZXNzLnN0dWRlbnQuczIiXSwianRpIjoiMjk0NmZiYjAtNzE1Ny00ZTMxLWJkNzEtMGM4YzQ3MGY0ZDhkIiwiaWF0IjoxNjIxMjU5MDk5LCJleHAiOjE2MjEyNjI2OTl9.kzZ6OFsGG4N1yQEjFgPs8oD-Vd0KiBt0a1a55ZCe9qA
##################
# Student s3: Neo
# Token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZW50cmFsLWF1dGgtc2VydmVyIiwiYXVkIjoiZGVtby1hcHAiLCJzdWIiOiJzdHVkZW50Lm5lb0BleGFtcGxlLmNvbSIsInJvbGVzIjpbInN0dWRlbnQiLCJhY2Nlc3Muc3R1ZGVudC5zMyJdLCJqdGkiOiJmNDc1ZGE2Mi1hNzE2LTQ1MWYtYmQyYS02Mjg4MzVjZDI3ZDgiLCJpYXQiOjE2MjEyNTkxMzksImV4cCI6MTYyMTI2MjczOX0.8lcGeB2XsHhvGYZnPYgH8-yyY5jh3mE4fvl6R8Euvxg
##################
# Student s4: phophen
# Token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZW50cmFsLWF1dGgtc2VydmVyIiwiYXVkIjoiZGVtby1hcHAiLCJzdWIiOiJzdHVkZW50LnBob3BoZW5AZXhhbXBsZS5jb20iLCJyb2xlcyI6WyJzdHVkZW50IiwiYWNjZXNzLnN0dWRlbnQuczQiXSwianRpIjoiM2Y4OTI4N2YtYzhkMy00ZjJkLTkzYjAtYzkxYTAxNTRhOTQ2IiwiaWF0IjoxNjIxMjU5MjExLCJleHAiOjE2MjEyNjI4MTF9.RJBNS3m5kQQ8cw5dxtG_oHXLWPkc3a1N-3_Alv5pH6k
#########################################################
token_amanda := "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZW50cmFsLWF1dGgtc2VydmVyIiwiYXVkIjoiZGVtby1hcHAiLCJzdWIiOiJhbWFuZGFAZXhhbXBsZS5jb20iLCJyb2xlcyI6WyJhZG1pbiIsInRlYWNoZXIiLCJhY2Nlc3MudGVhY2hlci50MSIsImFjY2Vzcy5zdHVkZW50LnMxIiwiYWNjZXNzLnN0dWRlbnQuczIiXSwianRpIjoiOTk1OTUyZjItMDZiYS00NDhiLTkxYTktMmQ3MTdiNTY2NmI0IiwiaWF0IjoxNjIxMjU3NjgzLCJleHAiOjE2MjEyNjEyODN9.cF3bB5f84WN85XE3a1dEZSoXQl9AO_oawN1xLXw_92Q"

token_john := "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZW50cmFsLWF1dGgtc2VydmVyIiwiYXVkIjoiZGVtby1hcHAiLCJzdWIiOiJqb2huQGV4YW1wbGUuY29tIiwicm9sZXMiOlsidGVhY2hlciIsImFjY2Vzcy50ZWFjaGVyLnQyIiwiYWNjZXNzLnN0dWRlbnQuczMiLCJhY2Nlc3Muc3R1ZGVudC5zNCJdLCJqdGkiOiIwMWMxN2Q3My1jN2VjLTRiMWYtOTgyNi1hODQ2YTc4YTI3MmQiLCJpYXQiOjE2MjEyNTg5NjcsImV4cCI6MTYyMTI2MjU2N30.rt7V7PBsI0-309Kx19VQs3kue5NoTraJOwXUwThyx9I"

token_student_amit := "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZW50cmFsLWF1dGgtc2VydmVyIiwiYXVkIjoiZGVtby1hcHAiLCJzdWIiOiJzdHVkZW50LmFtaXRAZXhhbXBsZS5jb20iLCJyb2xlcyI6WyJzdHVkZW50IiwiYWNjZXNzLnN0dWRlbnQuczEiXSwianRpIjoiNDY4ZmRmMWItYjZhOS00Y2I1LWIyYjctY2RmMTJjMzMyZjY2IiwiaWF0IjoxNjIxMjU5MDM4LCJleHAiOjE2MjEyNjI2Mzh9.Pfx5lQU5KqMMDTLNFflwNd_p9_I17eMlErmUAk_X4bQ"

token_student_neo := "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjZW50cmFsLWF1dGgtc2VydmVyIiwiYXVkIjoiZGVtby1hcHAiLCJzdWIiOiJzdHVkZW50Lm5lb0BleGFtcGxlLmNvbSIsInJvbGVzIjpbInN0dWRlbnQiLCJhY2Nlc3Muc3R1ZGVudC5zMyJdLCJqdGkiOiJmNDc1ZGE2Mi1hNzE2LTQ1MWYtYmQyYS02Mjg4MzVjZDI3ZDgiLCJpYXQiOjE2MjEyNTkxMzksImV4cCI6MTYyMTI2MjczOX0.8lcGeB2XsHhvGYZnPYgH8-yyY5jh3mE4fvl6R8Euvxg"

test_teachers_can_access_list_of_teachers {
	allow with input.attributes.request.http.method as "GET"
		 with input.parsed_path as ["teachers"]
		 with input.attributes.request.http.headers.authorization as token_amanda
}

test_teachers_can_access_self_data {
	allow with input.attributes.request.http.method as "GET"
		 with input.parsed_path as ["teachers", "t1"]
		 with input.attributes.request.http.headers.authorization as token_amanda
}

test_teachers_can_NOT_access_others_data {
	not allow with input.attributes.request.http.method as "GET"
		 with input.parsed_path as ["teachers", "t1"]
		 with input.attributes.request.http.headers.authorization as token_john
}

test_teachers_can_access_profile_of_student_they_are_leading {
	allow with input.attributes.request.http.method as "GET"
		 with input.parsed_path as ["students", "s1", "profile"]
		 with input.attributes.request.http.headers.authorization as token_amanda
}

test_teachers_can_NOT_access_profile_of_student_they_are_NOT_leading {
	not allow with input.attributes.request.http.method as "GET"
		 with input.parsed_path as ["students", "s1", "profile"]
		 with input.attributes.request.http.headers.authorization as token_john
}

test_teachers_can_access_public_profile_of_student_they_are_NOT_leading {
	allow with input.attributes.request.http.method as "GET"
		 with input.parsed_path as ["students", "s1", "public-profile"]
		# Act as John who does not lead Amit (student s1)
 with 		input.attributes.request.http.headers.authorization as token_john
}

test_students_can_access_public_profile_of_student {
	allow with input.attributes.request.http.method as "GET"
		 with input.parsed_path as ["students", "s1", "public-profile"]
		 with input.attributes.request.http.headers.authorization as token_student_neo
}

test_students_can_NOT_access_profile_of_other_student {
	not allow with input.attributes.request.http.method as "GET"
		 with input.parsed_path as ["students", "s1", "profile"]
		 with input.attributes.request.http.headers.authorization as token_student_neo
}

test_students_can_access_profile_of_self {
	allow with input.attributes.request.http.method as "GET"
		 with input.parsed_path as ["students", "s1", "profile"]
		 with input.attributes.request.http.headers.authorization as token_student_amit
}
