// import 'dart:convert';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:greenminds/models/map_model.dart';
// import 'package:greenminds/network/base.dart';
// import 'package:greenminds/providers/map_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<void> mapList(context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String url = Base.base + 'Company/List?type=map&isApproved=1&indexNumber=1';
//   final http.Response response = await http.get(
//     url,
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${prefs.getString('token')}',
//     },
//   );
//   print('response Status ' + response.statusCode.toString());

//   if (response.statusCode == 200) {
//     final parsed = jsonDecode(response.body);
//     List<MapModel> l =
//         parsed.map<MapModel>((json) => MapModel.fromJson(json)).toList();
//     Set<Marker> points = l
//         .map((e) => Marker(
//             markerId: MarkerId(e.id.toString()),
//             position: LatLng(e.latitude, e.longitude)))
//         .toSet();
//     Provider.of<MapProvider>(context).addPoints(points);
//   }
// }
