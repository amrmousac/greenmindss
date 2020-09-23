import 'dart:convert';

import 'package:greenminds/models/product_model.dart';
import 'package:greenminds/models/profile.dart';
import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Profile> profile() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = Base.base + 'User/Profile';
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('token')}',
      },
    );
    print('response Status ' + response.statusCode.toString());

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return Profile.fromJson(parsed);
    }
    return null;
  } catch (e) {
    throw Exception(e);
  }
}
