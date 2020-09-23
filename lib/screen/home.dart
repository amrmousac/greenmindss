import 'dart:async';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:greenminds/widgets/app_popup_menu.dart';
import 'companies_list.dart';
import 'companies_map.dart';
import 'products_market.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  PageController _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            AppPopUpMenu(),
          ],
          elevation: 0.0,
          title: Image.asset(
            'assets/images/logorow.png',
            width: 300.w,
          ),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            ProductsMarketPage(),
            CompaniesListPage(),
            CompaniesMapPage(),
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
            itemCornerRadius: 32.0,
            containerHeight: 60.0,
            backgroundColor: Theme.of(context).accentColor,
            selectedIndex: _currentPage,
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text('Products'),
                activeColor: Theme.of(context).primaryColor,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.business),
                title: Text(
                  'Companies',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                activeColor: Theme.of(context).primaryColor,
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.public),
                title: Text(
                  'Map',
                  maxLines: 2,
                ),
                activeColor: Theme.of(context).primaryColor,
              ),
            ],
            onItemSelected: (position) {
              setState(() {
                _currentPage = position;
                _pageController.jumpToPage(position);
              });
            }));
  }
}
