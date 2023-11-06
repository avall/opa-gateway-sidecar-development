package demo.authz

import input.attributes.request.http as http_request

allow {
	valid_token
	allow_action
}

token := {"valid": valid, "payload": payload} {
	[_, encoded] := split(http_request.headers.authorization, " ")

	# This statement invokes the built-in function `io.jwt.decode` passing the
	# parsed bearer_token as a parameter. The `io.jwt.decode` function returns an
	# array:
	#
	#	[valid, header, payload]
	#
	# In Rego, you can pattern match values using the `=` and `:=` operators. This
	# example pattern matches on the result to obtain the JWT payload.
	# Ref: https://www.openpolicyagent.org/docs/latest/policy-reference/#token-verification
	# [valid, _, payload] := io.jwt.decode_verify(encoded, {"secret": "secret"})

	### Using simple decoding and pure signature validation, as test JWTs will not be correctly formed i.e. correctly timestamped.
	# Verify the signature on the Bearer token. In this example the secret is
	# hardcoded into the policy however it could also be loaded via data or
	# an environment variable. Environment variables can be accessed using
	# the `opa.runtime()` built-in function.
	valid := io.jwt.verify_hs256(encoded, "supersecret")
	[_, payload, _] := io.jwt.decode(encoded)
}

valid_token {
	# Various token validation checks can be put here
	# - expiry time
	# - issuer identity
	# For this example, as simple token structure validity is asserted.
	token.valid
}

allow_action {
	http_request.method = "GET"
	["teachers"] = input.parsed_path
	token.payload.roles[_] == "teacher"
}

allow_action {
	http_request.method = "GET"
	["teachers"] = input.parsed_path
	token.payload.roles[_] == "student"
}

allow_action {
	http_request.method = "GET"
	["teachers"] = input.parsed_path
	token.payload.roles[_] == "admin"
}

allow_action {
	some teacherId
	http_request.method = "GET"
	["teachers", teacherId] = input.parsed_path
	token.payload.roles[_] == "teacher"

	# Access to self
	token.payload.roles[_] == concat("", {"access.teacher.", teacherId})
}

allow_action {
	some teacherId
	http_request.method = "GET"
	["teachers", teacherId] = input.parsed_path
	token.payload.roles[_] == "admin"
}

allow_action {
	http_request.method = "GET"
	["students"] = input.parsed_path
	token.payload.roles[_] == "teacher"
}

allow_action {
	http_request.method = "GET"
	["students"] = input.parsed_path
	token.payload.roles[_] == "student"
}

allow_action {
	http_request.method = "GET"
	["students"] = input.parsed_path
	token.payload.roles[_] == "admin"
}

allow_action {
	some studentId
	http_request.method = "GET"
	["students", studentId, "profile"] = input.parsed_path
	token.payload.roles[_] == "teacher"

	# Access to student, whome the teacher is leading
	token.payload.roles[_] == concat("", {"access.student.", studentId})
}

allow_action {
	some studentId
	http_request.method = "GET"
	["students", studentId, "profile"] = input.parsed_path
	token.payload.roles[_] == "student"

	# Access to self
	token.payload.roles[_] == concat("", {"access.student.", studentId})
}

allow_action {
	some studentId
	http_request.method = "GET"
	["students", studentId, "profile"] = input.parsed_path
	token.payload.roles[_] == "admin"
}

allow_action {
	http_request.method = "GET"
	["students", _, "public-profile"] = input.parsed_path
	token.payload.roles[_] == "teacher"
}

allow_action {
	http_request.method = "GET"
	["students", _, "public-profile"] = input.parsed_path
	token.payload.roles[_] == "student"
}
