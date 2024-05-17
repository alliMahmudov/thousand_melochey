// To parse this JSON data, do
//
//     final signInResponse = signInResponseFromJson(jsonString);

import 'dart:convert';

SignInResponse signInResponseFromJson(String str) => SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  final String? jwt;

  SignInResponse({
    this.jwt,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
    jwt: json["jwt"],
  );

  Map<String, dynamic> toJson() => {
    "jwt": jwt,
  };
}
