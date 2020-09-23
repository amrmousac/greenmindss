import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:greenminds/app_ads.dart';
import 'package:greenminds/models/product_details_model.dart';
import 'package:greenminds/network/product_details.dart';
import 'package:toast/toast.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

void showProductDialog(context, String image, String title, int id) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 250),
    context: context,
    pageBuilder: (_, __, ___) {
      return ProductDetails(
        id: id,
        image: image,
        title: title,
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(anim),
        child: child,
      );
    },
  );
}

class ProductDetails extends StatefulWidget {
  final int id;
  final String image;
  final String title;
  const ProductDetails({this.id, this.image, this.title});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          height: 1000.h,
          width: 600.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: widget.image,
                height: 350.h,
                width: 600.w,
                fit: BoxFit.fill,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, bottom: 4.0, top: 8.0),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      text: 'Product: ',
                      children: [
                        TextSpan(
                            text: widget.title,
                            style: TextStyle(fontWeight: FontWeight.w400))
                      ]),
                ),
              ),
              Expanded(
                child: FutureBuilder<ProductDetailsModel>(
                    future: productDetails(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 4.0),
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    text: 'Owner: ',
                                    children: [
                                      TextSpan(
                                          text: snapshot.data.ownerName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400))
                                    ]),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8.0),
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    text: 'Price: ',
                                    children: [
                                      TextSpan(
                                          text:
                                              "\$ ${snapshot.data.price} / MT",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400))
                                    ]),
                              ),
                            ),
                            item(context, Icons.phone, snapshot.data.phone,
                                launchType: 'tel'),
                            item(context, Icons.email, snapshot.data.email,
                                launchType: 'email'),
                            item(
                              context,
                              Icons.location_city,
                              snapshot.data.address,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 8.0),
                              child: Text(
                                'Description',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Text(snapshot.data.description),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Icon(
            icon,
            color: Colors.blue,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(text ?? ''),
          ),
        ),
      ],
    ),
  );
}
