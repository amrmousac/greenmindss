import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/network/add_company.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:toast/toast.dart';

class AddCompanyScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController location = TextEditingController();
  double latitude;
  double longitude;
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController description = TextEditingController();

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
                      decoration: InputDecoration(hintText: 'company name'),
                      controller: name,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the company name';
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
                      decoration: InputDecoration(
                          hintText: 'location: google map link'),
                      keyboardType: TextInputType.url,
                      controller: location,
                      validator: (value) {
                        Pattern pattern =
                            r"(http|ftp|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?";
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(value))
                          return 'Please enter a valid google map link';
                        else {
                          String url = location.text;
                          RegExp exp = new RegExp('@(.*),(.*),');
                          String latLong = exp.stringMatch(url) ?? ' ';
                          latLong = latLong.replaceAll('@', '');
                          List<String> m = latLong.split(',');
                          m.removeLast();
                          if (m.length != 2) {
                            return 'Please enter a correct link';
                          } else {
                            latitude = double.parse(m[0]);
                            longitude = double.parse(m[1]);
                          }
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                  child: TextFormField(
                      decoration: InputDecoration(hintText: 'country'),
                      keyboardType: TextInputType.text,
                      controller: country,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the country';
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                  child: TextFormField(
                      decoration: InputDecoration(hintText: 'city'),
                      keyboardType: TextInputType.text,
                      controller: city,
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
                      decoration: InputDecoration(hintText: 'website'),
                      keyboardType: TextInputType.url,
                      controller: website,
                      validator: (value) {
                        Pattern pattern =
                            r"(http|ftp|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?";
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(value))
                          return 'Please enter a website ex: https://www.google.com';
                        else {
                          return null;
                        }
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                  child: TextFormField(
                      decoration: InputDecoration(hintText: 'phone number'),
                      keyboardType: TextInputType.phone,
                      controller: phone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the company phone numebr';
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
                      controller: mail,
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
                            bool isSummitted = await addCompany(
                                name.text,
                                address.text,
                                location.text,
                                latitude,
                                longitude,
                                country.text,
                                city.text,
                                website.text,
                                phone.text,
                                mail.text,
                                description.text);
                            if (isSummitted) {
                              Toast.show("success", context,
                                  duration: Toast.LENGTH_LONG,
                                  backgroundColor:
                                      AppUtilities.appGreen.withOpacity(0.8),
                                  gravity: Toast.CENTER);
                              Navigator.pop(context);
                            } else {
                              Toast.show(
                                  "failed please try again later", context,
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
