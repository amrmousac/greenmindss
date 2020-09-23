import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/providers/filter_companies.dart';
import 'package:greenminds/widgets/filter_companies_widget.dart';
import 'package:provider/provider.dart';

class FilterCompaniesScreen extends StatefulWidget {
  @override
  _FilterCompaniesScreenState createState() => _FilterCompaniesScreenState();
}

class _FilterCompaniesScreenState extends State<FilterCompaniesScreen> {
  TextEditingController country = TextEditingController(),
      city = TextEditingController(),
      name = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _ads.myInterstitial.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider =
        Provider.of<CompaniesFilterProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Image.asset(
          'assets/images/logorow.png',
          height: 90.h,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(4.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Search',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            height: 70.h,
            child: TextField(
              decoration: InputDecoration(hintText: 'company name'),
              controller: name,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                  height: 70.h,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'country'),
                    controller: country,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                  height: 70.h,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'city'),
                    controller: city,
                  ),
                ),
              ),
            ],
          ),
          RaisedButton(
            onPressed: () {
              filterProvider.name = '';
              filterProvider.country = '';
              filterProvider.city = '';
              filterProvider.j = 0;
              Timer(Duration(milliseconds: 500), () {
                filterProvider.name = name.text;
                filterProvider.country = country.text;
                filterProvider.city = city.text;
              });
            },
            child: Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(child: FilterCompaniesWidget())
        ],
      ),
    );
  }
}
