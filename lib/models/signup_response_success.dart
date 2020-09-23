// To parse this JSON data, do
//
//     final SignupResponseSuccess = SignupResponseSuccessFromJson(jsonString);

import 'dart:convert';

SignupResponseSuccess registerResponseSuccessFromJson(String str) =>
    SignupResponseSuccess.fromJson(json.decode(str));

String registerResponseSuccessToJson(SignupResponseSuccess data) =>
    json.encode(data.toJson());

class SignupResponseSuccess {
  SignupResponseSuccess({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.id,
    this.username,
    this.email,
    this.isSubscribe,
    this.emailConfirmed,
    this.issued,
    this.expires,
  });

  String accessToken;
  String tokenType;
  int expiresIn;
  String id;
  String username;
  String email;
  String isSubscribe;
  String emailConfirmed;
  String issued;
  String expires;

  factory SignupResponseSuccess.fromJson(Map<String, dynamic> json) =>
      SignupResponseSuccess(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        id: json["Id"],
        username: json["Username"],
        email: json["Email"],
        isSubscribe: json["IsSubscribe"],
        emailConfirmed: json["EmailConfirmed"],
        issued: json[".issued"],
        expires: json[".expires"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "Id": id,
        "Username": username,
        "Email": email,
        "IsSubscribe": isSubscribe,
        "EmailConfirmed": emailConfirmed,
        ".issued": issued,
        ".expires": expires,
      };
}
