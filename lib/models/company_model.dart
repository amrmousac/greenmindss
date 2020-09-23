// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

CompanyModel companyModelFromJson(String str) =>
    CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  CompanyModel({
    this.id,
    this.name,
    this.address,
    this.location,
    this.latitude,
    this.longitude,
    this.country,
    this.city,
    this.website,
    this.phone,
    this.mail,
    this.description,
  });

  int id;
  String name;
  String address;
  String location;
  double latitude;
  double longitude;
  String country;
  String city;
  String website;
  String phone;
  String mail;
  String description;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        id: json["Id"],
        name: json["Name"],
        address: json["Address"],
        location: json["Location"],
        latitude: json["Latitude"].toDouble(),
        longitude: json["Longitude"].toDouble(),
        country: json["Country"],
        city: json["City"],
        website: json["Website"],
        phone: json["Phone"],
        mail: json["Mail"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Address": address,
        "Location": location,
        "Latitude": latitude,
        "Longitude": longitude,
        "Country": country,
        "City": city,
        "Website": website,
        "Phone": phone,
        "Mail": mail,
        "Description": description,
      };
}
