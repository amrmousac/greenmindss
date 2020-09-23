import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/providers/filter_product.dart';
import 'package:greenminds/widgets/filter_products_widget.dart';
import 'package:provider/provider.dart';

class FilterProductsScreen extends StatefulWidget {
  @override
  _FilterProductsScreenState createState() => _FilterProductsScreenState();
}

class _FilterProductsScreenState extends State<FilterProductsScreen> {
  TextEditingController address = TextEditingController(),
      description = TextEditingController(),
      ownerName = TextEditingController(),
      name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filterProvider =
        Provider.of<ProductsFilterProvider>(context, listen: false);
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
            margin: const EdgeInsets.all(4.0),
            height: 70.h,
            child: TextField(
              decoration: InputDecoration(hintText: 'Product Name'),
              controller: name,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 4.0, left: 4.0, bottom: 4.0),
            height: 70.h,
            child: TextField(
              decoration: InputDecoration(hintText: 'address'),
              controller: address,
            ),
          ),
          RaisedButton(
            onPressed: () {
              filterProvider.name = '';
              filterProvider.ownerName = '';
              filterProvider.address = '';
              filterProvider.description = '';
              filterProvider.j = 0;
              Timer(Duration(milliseconds: 500), () {
                filterProvider.name = name.text;
                filterProvider.ownerName = ownerName.text;
                filterProvider.address = address.text;
                filterProvider.description = description.text;
                print('address = ${address.text}==${filterProvider.address}');
              });
            },
            child: Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(child: FilterProductsWidget())
        ],
      ),
    );
  }
}
