import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/models/product_model.dart';
import 'package:greenminds/screen/update_products.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:greenminds/widgets/product_details.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  bool showStatus;
  Text status;
  ProductCard({this.product, this.showStatus = false});
  @override
  Widget build(BuildContext context) {
    switch (product.status) {
      case 0:
        status = Text(
          'Pending',
          style: TextStyle(color: Colors.yellow),
        );
        break;
      case 1:
        status = Text(
          'Accepted',
          style: TextStyle(color: AppUtilities.appGreen),
        );
        break;
      case 2:
        status = Text(
          'Rejected',
          style: TextStyle(color: Colors.redAccent),
        );
        break;
      default:
    }
    String image = product.image.replaceRange(0, 1, '');
    image = 'http://aeliwa-001-site1.ctempurl.com' + image;

    return InkWell(
      onTap: () {
        showStatus
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateProduct(
                          id: product.id,
                        )))
            : showProductDialog(
                context,
                image,
                product.name,
                product.id,
              );
      },
      child: Container(
        //margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),

        decoration: BoxDecoration(color: Colors.white,
            //borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                  offset: Offset(0, 2.0))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: image,
              fit: BoxFit.fill,
              width: 400.w,
              height: 300.h,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$ ${product.price} / MT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppUtilities.appGreen),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Text(
                          product.description,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                    showStatus ? status : Container(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
