import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenminds/providers/map_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/screen/add_company.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

class CompaniesMapPage extends StatefulWidget {
  @override
  _CompaniesMapPageState createState() => _CompaniesMapPageState();
}

class _CompaniesMapPageState extends State<CompaniesMapPage>
    with AutomaticKeepAliveClientMixin {
  Location location = new Location();

  bool _serviceEnabled;
  bool _hasLocation = false;

  PermissionStatus _permissionGranted;
  LocationData _locationData;

  getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    if (_serviceEnabled) {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          _hasLocation = true;
        }
      }
    }
    _locationData = await location.getLocation();
    print('location initialized');
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapProvider.points.add(Marker(
        markerId: MarkerId('MyLocation'),
        position: LatLng(_locationData.latitude, _locationData.longitude)));
    print('location addsed');
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    try {
      mapProvider.mapList(context);
    } catch (e) {
      print(e);
    }

    return Scaffold(
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        child: AppMap(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 700.w,
        alignment: Alignment.bottomLeft,
        child: SizedBox(
          width: 300.w,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCompanyScreen()));
            },
            backgroundColor: AppUtilities.appGreen,
            isExtended: true,
            materialTapTargetSize: MaterialTapTargetSize.padded,
            child: Text(
              'Add Company',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AppMap extends StatelessWidget {
  Completer<GoogleMapController> _googleMapController =
      Completer<GoogleMapController>();

  Future<LatLng> getLocation() async {
    Location location = new Location();
    LocationData _locationData = await location.getLocation();
    return LatLng(
        _locationData.latitude ?? 31.0, _locationData.longitude ?? 31.0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(
      builder: (context, markers, _) {
        return FutureBuilder<LatLng>(
            future: getLocation(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return GoogleMap(
                  buildingsEnabled: true,
                  mapToolbarEnabled: false,
                  initialCameraPosition: CameraPosition(
                      target: snap.data,
                      tilt: 59.440717697143555,
                      zoom: 10.151926040649414),
                  onMapCreated: (GoogleMapController controller) {
                    _googleMapController.complete(controller);
                  },
                  markers: markers.points,
                );
              }
            });
      },
    );
  }
}
