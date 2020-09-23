import 'dart:convert';
import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> addProduct(
  String name,
  String ownerName,
  String phone,
  String email,
  String description,
  String address,
  double price,
  String bytes,
) async {
  try {
    String url = Base.base + 'Product/';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
        body: jsonEncode(<String, dynamic>{
          "Name": name,
          "Address": address,
          "OwnerName": ownerName,
          "Phone": phone,
          "Email": email,
          "Description": description,
          "price": price,
          "Bytes": bytes,
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
