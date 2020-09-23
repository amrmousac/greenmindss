import 'dart:convert';
import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> updateProduct(
  String id,
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
    String url = Base.base + 'Product/$id';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = bytes != null
        ? jsonEncode(<String, dynamic>{
            "Name": name,
            "Address": address,
            "OwnerName": ownerName,
            "Phone": phone,
            "Email": email,
            "Description": description,
            "price": price,
            "Bytes": bytes,
          })
        : jsonEncode(<String, dynamic>{
            "Name": name,
            "Address": address,
            "OwnerName": ownerName,
            "Phone": phone,
            "Email": email,
            "Description": description,
            "price": price,
          });
    final http.Response response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}',
      },
      body: body,
    );
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
