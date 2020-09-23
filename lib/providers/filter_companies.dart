import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greenminds/models/list_model.dart';
import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CompaniesFilterProvider with ChangeNotifier {
  String _name = '', _country = '', _city = '';

  String get name => _name;
  set name(name) {
    _name = name;
    notifyListeners();
  }

  String get country => _country;
  set country(country) {
    _country = country;
    notifyListeners();
  }

  String get city => _city;
  set city(city) {
    _city = city;
    notifyListeners();
  }

  int j = 0;
  Future<List<ListModel>> companiesFilterList(
    int index,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String n = (_name == "") ? "" : "name=$_name";
    String c = (_country == "") ? "" : "&Country=$_country";
    String c2 = (_city == "") ? "" : "&city=$_city";

    String url = Base.base + 'Company/Filter?$n$c$c2&indexNumber=${++j}';
    print(url);
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
      return parsed.map<ListModel>((json) => ListModel.fromJson(json)).toList();
    }
    return [];
  }
}
