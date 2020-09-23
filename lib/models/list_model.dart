// To parse this JSON data, do
//
//     final listModel = listModelFromJson(jsonString);

import 'dart:convert';

List<ListModel> listModelFromJson(String str) =>
    List<ListModel>.from(json.decode(str).map((x) => ListModel.fromJson(x)));

String listModelToJson(List<ListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListModel {
  ListModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
