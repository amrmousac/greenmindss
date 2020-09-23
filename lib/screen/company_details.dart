import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenminds/app_ads.dart';
import 'package:greenminds/models/company_model.dart';
import 'package:greenminds/network/company.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyDetailsScreen extends StatefulWidget {
  final int id;
  CompanyDetailsScreen(this.id);

  @override
  _CompanyDetailsScreenState createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  AppAds _ads = AppAds();

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: _ads.appId());
    _ads.myBanner
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ads.myBanner.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Image.asset(
          'assets/images/logorow.png',
          height: AppBar().preferredSize.height * 0.9,
        ),
      ),
      body: FutureBuilder<CompanyModel>(
          future: company(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CompanyData(snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }
          }),
    );
  }
}

class CompanyData extends StatelessWidget {
  final CompanyModel company;
  CompanyData(this.company);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8.0,
                    spreadRadius: 0.5,
                    offset: Offset(0, 2))
              ],
            ),
            child: Text(
              company.name ?? '',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.location_city,
                        color: Colors.blue,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                '${company.country ?? ''},${company.city ?? ''}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              company.address,
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (await canLaunch('${company.location}')) {
                      await launch('${company.location}');
                    } else {
                      Toast.show("Sorry, can not open location", context,
                          duration: Toast.LENGTH_LONG,
                          backgroundColor: Colors.red.withOpacity(0.8),
                          gravity: Toast.CENTER);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                item(context, Icons.phone, company.phone, launchType: 'tel'),
                item(context, Icons.email, company.mail, launchType: 'email'),
                item(context, Icons.web, company.website, launchType: 'web'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              'Description',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Text(
              company.description ?? '',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget item(context, IconData icon, String text, {String launchType}) {
    return InkWell(
      onTap: () async {
        try {
          switch (launchType) {
            case 'tel':
              print('tel');
              if (await canLaunch('tel: $text')) {
                await launch('tel: $text');
              } else {
                throw 'Could not launch $text';
              }
              break;
            case 'email':
              print('email');
              final Uri _emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: '$text',
                  queryParameters: {'subject': ' '});
              if (await canLaunch(_emailLaunchUri.toString())) {
                await launch(_emailLaunchUri.toString());
              } else {
                throw 'Could not launch $text';
              }
              break;
            case 'web':
              print('web');
              if (await canLaunch('$text')) {
                await launch('$text');
              } else {
                await launch('http:$text');
                // throw 'Could not launch $text';
              }
              break;
            default:
          }
        } catch (e) {
          print(e);
          Toast.show("Sorry, can not open $text", context,
              duration: Toast.LENGTH_LONG,
              backgroundColor: Colors.red.withOpacity(0.8),
              gravity: Toast.CENTER);
        }
      },
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Text(text ?? ''),
          ),
        ],
      ),
    );
  }
}
