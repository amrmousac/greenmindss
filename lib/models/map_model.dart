// To parse this JSON data, do
//
//     final mapModel = mapModelFromJson(jsonString);

import 'dart:convert';

List<MapModel> mapModelFromJson(String str) =>
    List<MapModel>.from(json.decode(str).map((x) => MapModel.fromJson(x)));

String mapModelToJson(List<MapModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MapModel {
  MapModel({
    this.id,
    this.latitude,
    this.longitude,
  });

  int id;
  double latitude;
  double longitude;

  factory MapModel.fromJson(Map<String, dynamic> json) => MapModel(
        id: json["Id"],
        latitude: json["Latitude"].toDouble(),
        longitude: json["Longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Latitude": latitude,
        "Longitude": longitude,
      };
}
