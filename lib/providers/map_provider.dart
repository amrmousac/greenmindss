import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenminds/models/map_model.dart';
import 'package:greenminds/network/base.dart';
import 'package:greenminds/screen/company_details.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MapProvider with ChangeNotifier {
  Set<Marker> _points = {};

  Set<Marker> get points => _points;

  void addPoints(Set<Marker> points) {
    _points.addAll(points);
    notifyListeners();
  }

  set points(points) {
    _points = points;
    notifyListeners();
  }

  int _index = 1;
  Future<void> mapList(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = Base.base +
          'Company/List?type=map&isApproved=1&indexNumber=${_index++}';
      final http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
      );
      print('response Status ' + response.statusCode.toString());
      print(_index.toString());

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        List<MapModel> l =
            parsed.map<MapModel>((json) => MapModel.fromJson(json)).toList();

        BitmapDescriptor bitmapDescriptor =
            await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'assets/images/mapicon25.png',
        );
        Set<Marker> points = l
            .map((e) => Marker(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompanyDetailsScreen(e.id)));
                },
                icon: bitmapDescriptor,
                markerId: MarkerId(e.id.toString()),
                position: LatLng(e.latitude, e.longitude)))
            .toSet();
        _points.addAll(points);
        notifyListeners();
        Timer(Duration(microseconds: 500), () {
          mapList(context);
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
