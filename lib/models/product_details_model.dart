// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) =>
    ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) =>
    json.encode(data.toJson());

class ProductDetailsModel {
  ProductDetailsModel(
      {this.id,
      this.name,
      this.ownerName,
      this.description,
      this.email,
      this.image,
      this.phone,
      this.address,
      this.price});

  int id;
  String name;
  String ownerName;
  String description;
  String email;
  String image;
  String phone;
  String address;
  double price;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
          id: json["Id"],
          name: json["Name"],
          ownerName: json["OwnerName"],
          description: json["Description"],
          email: json["Email"],
          image: json["Image"],
          phone: json["Phone"],
          address: json["Address"],
          price: json["Price"]);

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "OwnerName": ownerName,
        "Description": description,
        "Email": email,
        "Image": image,
        "Phone": phone,
        "Address": address,
        "Price": price
      };
}
