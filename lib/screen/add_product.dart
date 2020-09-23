import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/network/add_product.dart';

import 'package:greenminds/themes/app_utilities.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController ownerName = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController description = TextEditingController();

  TextEditingController price = TextEditingController();

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
            width: 50.0,
            height: 50.0,
          );
        } else if (snap.data == null) {
          return Icon(
            Icons.image,
            color: AppUtilities.appGreen,
            size: 42.0,
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Image.asset(
          'assets/images/logorow.png',
          height: 90.h,
        ),
      ),
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
                            'pick image',
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                      child: Text(
                        'Summit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            Toast.show("is Summitting", context,
                                duration: Toast.LENGTH_LONG,
                                backgroundColor: Colors.yellow.withOpacity(0.7),
                                gravity: Toast.CENTER);

                            bool isSummitted = await addProduct(
                                name.text,
                                ownerName.text,
                                phone.text,
                                email.text,
                                description.text,
                                address.text,
                                double.parse(price.text),
                                image64base);

                            if (isSummitted) {
                              Toast.show("success", context,
                                  duration: Toast.LENGTH_LONG,
                                  backgroundColor:
                                      AppUtilities.appGreen.withOpacity(0.8),
                                  gravity: Toast.CENTER);
                              Navigator.pop(context);
                            } else {
                              Toast.show(
                                  "failed. please, make sure your data is correct",
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
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
