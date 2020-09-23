import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:greenminds/app_ads.dart';
import 'package:greenminds/models/list_model.dart';
import 'package:greenminds/network/companies_list.dart';
import 'package:greenminds/screen/company_details.dart';
import 'package:greenminds/screen/filter_companies.dart';
import 'package:greenminds/screen/home.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:pagination_view/pagination_view.dart';

class CompaniesListPage extends StatefulWidget {
  @override
  _CompaniesListPageState createState() => _CompaniesListPageState();
}

class _CompaniesListPageState extends State<CompaniesListPage>
/* with AutomaticKeepAliveClientMixin*/ {
  AppAds _ads = AppAds();
  bool showAd = true;
  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: _ads.appId());
    _ads.myBanner
      ..load()
      ..show(anchorOffset: 60.0, anchorType: AnchorType.bottom);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (showAd) {
      _ads.myBanner.dispose();
      showAd = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: () async {
          Timer(Duration(microseconds: 500), () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          });
        },
        child: SizedBox.expand(
          child: Container(
            margin: EdgeInsets.all(0.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FilterCompaniesScreen())),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: AppUtilities.appGreen,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppUtilities.appBlue),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: PaginationView<ListModel>(
                    bottomLoader: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        // optional
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    initialLoader: Center(
                      // optional
                      child: CircularProgressIndicator(),
                    ),
                    onError: (dynamic error) => Center(
                      child: Center(child: Text('Some error occured ')),
                    ),
                    onEmpty: Center(
                      child: Text('No Data'),
                    ),
                    pageFetch: companiesList,
                    itemBuilder:
                        (BuildContext context, ListModel company, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 4.0),
                        child: InkWell(
                            onTap: () {
                              if (showAd) {
                                _ads.myBanner.dispose();
                                showAd = false;
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CompanyDetailsScreen(company.id)));
                            },
                            child: Container(
                                margin: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200],
                                        blurRadius: 8.0,
                                        spreadRadius: 2.0,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Center(
                                      child: Text(
                                    company.name,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700),
                                  )),
                                ))),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
