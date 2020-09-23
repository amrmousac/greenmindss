import 'dart:convert';

import 'package:greenminds/models/list_model.dart';
import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<ListModel>> companiesList(
  int index,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int i = ((index / 50).ceil() + 1).toInt();
  String url = Base.base + 'Company/List?type=list&isApproved=1&indexNumber=$i';
  final http.Response response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('token')}',
    },
  );
  print('response Status ' + response.statusCode.toString());
  print(i);
  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body);
    return parsed.map<ListModel>((json) => ListModel.fromJson(json)).toList();
  }
  return [];
}
