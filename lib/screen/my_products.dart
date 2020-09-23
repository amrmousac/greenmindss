import 'dart:async';

import 'package:flutter/material.dart';
import 'package:greenminds/models/product_model.dart';
import 'package:greenminds/network/my_products.dart';
import 'package:greenminds/screen/add_product.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:greenminds/widgets/product_card.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Image.asset(
          'assets/images/logorow.png',
          height: 90.h,
        ),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: () async {
          Timer(Duration(microseconds: 500), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MyProductsScreen()));
          });
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: PaginationView<ProductModel>(
              paginationViewType: PaginationViewType.gridView,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.60),
              padding: EdgeInsets.all(8.0),
              bottomLoader: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              initialLoader: Center(
                child: CircularProgressIndicator(),
              ),
              onError: (dynamic error) => Center(
                child: Text('Some error occured $error'),
              ),
              onEmpty: Center(
                child: Text('you don\'nt have any products'),
              ),
              preloadedItems: [],
              pageFetch: myProducts,
              itemBuilder:
                  (BuildContext context, ProductModel product, int index) {
                return ProductCard(
                  product: product,
                  showStatus: true,
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 300.w,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddProductScreen()));
          },
          backgroundColor: AppUtilities.appGreen,
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          child: Text(
            'Add Product',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
