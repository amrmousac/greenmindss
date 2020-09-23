// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.status,
  });

  int id;
  String name;
  String description;
  String image;
  double price;
  int status;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        image: json["Image"],
        price: json["Price"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "Image": image,
        "Price": price,
        "status": status
      };
}
