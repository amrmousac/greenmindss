import 'dart:convert';
import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> addCompany(
  String name,
  String address,
  String location,
  double latitude,
  double longitude,
  String country,
  String city,
  String website,
  String phone,
  String mail,
  String description,
) async {
  try {
    String url = Base.base + 'Company';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
        body: jsonEncode(<String, dynamic>{
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
          "IsApproved": false,
        }));
    print('response Status ' + response.statusCode.toString());
    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw Exception(e);
  }
}
