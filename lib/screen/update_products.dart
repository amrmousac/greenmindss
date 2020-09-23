import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greenminds/models/product_details_model.dart';
import 'package:greenminds/network/product_details.dart';
import 'package:greenminds/network/update_product.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateProduct extends StatefulWidget {
  final int id;

  const UpdateProduct({
    this.id,
  });

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
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
      body: FutureBuilder<ProductDetailsModel>(
          future: productDetails(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ProductData(snapshot.data);
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

class ProductData extends StatefulWidget {
  final ProductDetailsModel product;
  ProductData(this.product);
  @override
  _ProductDataState createState() => _ProductDataState();
}

class _ProductDataState extends State<ProductData> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController name;

  TextEditingController ownerName;

  TextEditingController phone;

  TextEditingController address;

  TextEditingController email;

  TextEditingController description;

  TextEditingController price;

  Future<File> file;
  String image64base;

  chooseImage() async {
    try {
      setState(() {
        file = ImagePicker.pickImage(source: ImageSource.gallery);
      });
    } catch (e) {
      Toast.show("Can not pick image", context,
          duration: Toast.LENGTH_LONG,
          backgroundColor: Colors.red.withOpacity(0.8),
          gravity: Toast.CENTER);
    }
  }

  Widget showImage() => FutureBuilder<File>(
      future: file,
      builder: (context, snap) {
        if (snap.hasData) {
          image64base = base64Encode(snap.data.readAsBytesSync());
          return Image.file(
            snap.data,
            width: 200.w,
            height: 100.h,
          );
        } else if (snap.data == null) {
          String image = widget.product.image.replaceRange(0, 1, '');
          image = 'http://aeliwa-001-site1.ctempurl.com' + image;
          return Image.network(
            image,
            width: 200.w,
            height: 100.h,
          );
        } else if (snap.hasError) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = TextEditingController(text: widget.product.name);

    ownerName = TextEditingController(text: widget.product.ownerName);

    phone = TextEditingController(text: widget.product.phone);

    address = TextEditingController(text: widget.product.address);

    email = TextEditingController(text: widget.product.email);

    description = TextEditingController(text: widget.product.description);

    price = TextEditingController(text: widget.product.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                  child: TextFormField(
                      decoration: InputDecoration(hintText: 'product name'),
                      controller: name,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the product name';
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                  child: TextFormField(
                      decoration: InputDecoration(hintText: 'owner name'),
                      controller: ownerName,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the owner name';
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                  child: TextFormField(
                      decoration: InputDecoration(hintText: 'address'),
                      controller: address,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the company address';
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                  child: TextFormField(
                      decoration:
                          InputDecoration(hintText: 'your Phone Number'),
                      keyboardType: TextInputType.phone,
                      controller: phone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                  child: TextFormField(
                      decoration: InputDecoration(hintText: 'price'),
                      keyboardType: TextInputType.number,
                      controller: price,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the city';
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                  child: TextFormField(
                      decoration: InputDecoration(hintText: 'email'),
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      validator: (value) {
                        Pattern pattern =
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(value))
                          return 'Please enter a valid email';
                        else {
                          return null;
                        }
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                  //height: 400.h,
                  child: TextFormField(
                    maxLines: 8,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'description',
                    ),
                    controller: description,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton.icon(
                          color: AppUtilities.appBlue,
                          label: Text(
                            'change image',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(
                            Icons.file_upload,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            chooseImage();
                          }),
                      showImage(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100.0,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        padding: EdgeInsets.all(4.0),
        width: 700.w,
        child: SizedBox(
          width: 300.w,
          child: FloatingActionButton(
            isExtended: true,
            heroTag: 'btn1',
            backgroundColor: AppUtilities.appGreen,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                try {
                  Toast.show("is Summitting", context,
                      duration: Toast.LENGTH_LONG,
                      backgroundColor: Colors.yellow.withOpacity(0.7),
                      gravity: Toast.CENTER);

                  bool isSummitted = await updateProduct(
                      widget.product.id.toString(),
                      name.text,
                      ownerName.text,
                      phone.text,
                      email.text,
                      description.text,
                      address.text,
                      double.parse(price.text),
                      image64base);
                  print(image64base);
                  print(widget.product.id.toString());
                  if (isSummitted) {
                    Toast.show("success", context,
                        duration: Toast.LENGTH_LONG,
                        backgroundColor: AppUtilities.appGreen.withOpacity(0.8),
                        gravity: Toast.CENTER);
                    Navigator.pop(context);
                  } else {
                    Toast.show("failed. please, make sure your data is correct",
                        context,
                        duration: Toast.LENGTH_LONG,
                        backgroundColor: Colors.red.withOpacity(0.8),
                        gravity: Toast.CENTER);
                  }
                } catch (e) {
                  Toast.show("error can not send data", context,
                      duration: Toast.LENGTH_LONG,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      gravity: Toast.CENTER);
                }
              } else {
                Toast.show("some fields not correct", context,
                    duration: Toast.LENGTH_LONG,
                    backgroundColor: Colors.red.withOpacity(0.8),
                    gravity: Toast.TOP);
              }
            },
            child: Text(
              'Update Product',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
