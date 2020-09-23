// To parse this JSON data, do
//
//     final loginResponseSuccess = loginResponseSuccessFromJson(jsonString);

import 'dart:convert';

LoginResponseSuccess loginResponseSuccessFromJson(String str) =>
    LoginResponseSuccess.fromJson(json.decode(str));

String loginResponseSuccessToJson(LoginResponseSuccess data) =>
    json.encode(data.toJson());

class LoginResponseSuccess {
  LoginResponseSuccess({
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

  factory LoginResponseSuccess.fromJson(Map<String, dynamic> json) =>
      LoginResponseSuccess(
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
