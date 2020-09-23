// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.name,
    this.email,
    this.country,
    this.phoneNumber,
    this.isSubscripe,
    this.subscriptionDate,
    this.subscriptionExpires,
  });

  String name;
  String email;
  String country;
  String phoneNumber;
  bool isSubscripe;
  dynamic subscriptionDate;
  dynamic subscriptionExpires;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["Name"],
        email: json["Email"],
        country: json["Country"],
        phoneNumber: json["PhoneNumber"],
        isSubscripe: json["IsSubscripe"],
        subscriptionDate: json["SubscriptionDate"],
        subscriptionExpires: json["SubscriptionExpires"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Email": email,
        "Country": country,
        "PhoneNumber": phoneNumber,
        "IsSubscripe": isSubscripe,
        "SubscriptionDate": subscriptionDate,
        "SubscriptionExpires": subscriptionExpires,
      };
}
