import 'dart:convert';
import 'package:greenminds/models/company_model.dart';
import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<CompanyModel> company(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String url = Base.base + 'Company/$id';
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
    return CompanyModel.fromJson(parsed);
  }
  return null;
}
