import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greenminds/models/list_model.dart';
import 'package:greenminds/models/product_model.dart';
import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductsFilterProvider with ChangeNotifier {
  String _name = '', _address = '', _ownerName = '', _description = '';

  String get name => _name;
  set name(name) {
    _name = name;
    notifyListeners();
  }

  String get address => _address;
  set address(address) {
    _address = address;
    notifyListeners();
  }

  String get ownerName => _ownerName;
  set ownerName(ownerName) {
    _ownerName = ownerName;
    notifyListeners();
  }

  String get description => _description;
  set description(description) {
    _description = description;
    notifyListeners();
  }

  int j = 0;
  Future<List<ProductModel>> productsFilterList(
    int index,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String n = (_name == "") ? "" : "Name=$_name";
    String c = (_address == "") ? "" : "&address=$_address";
    String c2 = (_ownerName == "") ? "" : "&OwnerName=$_ownerName";
    String c3 = (_description == "") ? "" : "&Description=$_description";

    String url = Base.base + 'Product/Filter?$n$c$c2$c3&indexNumber=${++j}';
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
      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    }
    return [];
  }
}
