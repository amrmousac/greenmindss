// To parse this JSON data, do
//
//     final signUpResponseFail = signUpResponseFailFromJson(jsonString);

import 'dart:convert';

List<SignUpResponseFail> signUpResponseFailFromJson(String str) =>
    List<SignUpResponseFail>.from(
        json.decode(str).map((x) => SignUpResponseFail.fromJson(x)));

String signUpResponseFailToJson(List<SignUpResponseFail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SignUpResponseFail {
  SignUpResponseFail({
    this.message,
    this.modelState,
  });

  String message;
  ModelState modelState;

  factory SignUpResponseFail.fromJson(Map<String, dynamic> json) =>
      SignUpResponseFail(
        message: json["Message"],
        modelState: ModelState.fromJson(json["ModelState"]),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "ModelState": modelState.toJson(),
      };
}

class ModelState {
  ModelState({
    this.modelConfirmPassword,
    this.modelPassword,
    this.empty,
    this.modelEmail,
  });

  List<String> modelConfirmPassword;
  List<String> modelPassword;
  List<String> empty;
  List<String> modelEmail;

  factory ModelState.fromJson(Map<String, dynamic> json) => ModelState(
        modelConfirmPassword: json["model.ConfirmPassword"] == null
            ? null
            : List<String>.from(json["model.Password"].map((x) => x)),
        modelPassword: json["model.Password"] == null
            ? null
            : List<String>.from(json["model.ConfirmPassword"].map((x) => x)),
        empty:
            json[""] == null ? null : List<String>.from(json[""].map((x) => x)),
        modelEmail: json["model.Email"] == null
            ? null
            : List<String>.from(json["model.Email"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "model.ConfirmPassword": modelConfirmPassword == null
            ? null
            : List<dynamic>.from(modelConfirmPassword.map((x) => x)),
        "": List<dynamic>.from(empty.map((x) => x)),
        "model.Email": modelEmail == null
            ? null
            : List<dynamic>.from(modelEmail.map((x) => x)),
      };
}
