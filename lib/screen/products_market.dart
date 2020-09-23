import 'dart:async';

import 'package:flutter/material.dart';
import 'package:greenminds/models/product_model.dart';
import 'package:greenminds/network/products_list.dart';
import 'package:greenminds/screen/filter_products.dart';
import 'package:greenminds/screen/home.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:greenminds/widgets/product_card.dart';
import 'package:pagination_view/pagination_view.dart';

class ProductsMarketPage extends StatefulWidget {
  @override
  _ProductsMarketPageState createState() => _ProductsMarketPageState();
}

class _ProductsMarketPageState extends State<ProductsMarketPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
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
                child: Container(
                  margin: EdgeInsets.all(0.0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilterProductsScreen())),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
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
                        child: PaginationView<ProductModel>(
                          paginationViewType: PaginationViewType.gridView,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  childAspectRatio: 0.7),
                          padding: EdgeInsets.all(8.0),
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
                            child: Text('Some error occured'),
                          ),
                          onEmpty: Center(
                            child: Text('No Data'),
                          ),
                          preloadedItems: [],
                          pageFetch: productsList,
                          itemBuilder: (BuildContext context,
                              ProductModel product, int index) {
                            return ProductCard(
                              product: product,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  @override
  bool get wantKeepAlive => true;
}
