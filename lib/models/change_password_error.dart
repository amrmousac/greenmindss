// To parse this JSON data, do
//
//     final changePasswordError = changePasswordErrorFromJson(jsonString);

import 'dart:convert';

List<ChangePasswordError> changePasswordErrorFromJson(String str) =>
    List<ChangePasswordError>.from(
        json.decode(str).map((x) => ChangePasswordError.fromJson(x)));

String changePasswordErrorToJson(List<ChangePasswordError> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChangePasswordError {
  ChangePasswordError({
    this.message,
    this.modelState,
  });

  String message;
  ModelState modelState;

  factory ChangePasswordError.fromJson(Map<String, dynamic> json) =>
      ChangePasswordError(
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
    this.empty,
    this.modelNewPassword,
    this.modelConfirmPassword,
  });

  List<String> empty;
  List<String> modelNewPassword;
  List<String> modelConfirmPassword;

  factory ModelState.fromJson(Map<String, dynamic> json) => ModelState(
        empty:
            json[""] == null ? [''] : List<String>.from(json[""].map((x) => x)),
        modelNewPassword: json["model.NewPassword"] == null
            ? ['']
            : List<String>.from(json["model.NewPassword"].map((x) => x)),
        modelConfirmPassword: json["model.ConfirmPassword"] == null
            ? ['']
            : List<String>.from(json["model.ConfirmPassword"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "": empty == null ? null : List<dynamic>.from(empty.map((x) => x)),
        "model.NewPassword": modelNewPassword == null
            ? null
            : List<dynamic>.from(modelNewPassword.map((x) => x)),
        "model.ConfirmPassword": modelConfirmPassword == null
            ? null
            : List<dynamic>.from(modelConfirmPassword.map((x) => x)),
      };
}
