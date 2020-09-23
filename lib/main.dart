import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greenminds/providers/filter_companies.dart';
import 'package:greenminds/providers/filter_product.dart';
import 'package:greenminds/providers/map_provider.dart';
import 'package:greenminds/screen/splash.dart';
import 'package:provider/provider.dart';
import 'themes/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MapProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CompaniesFilterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductsFilterProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Green Minds',
        theme: appTheme,
        home: GreenMindApp(),
      ),
    );
  }
}

class GreenMindApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      height: 1440,
      width: 720,
      allowFontScaling: true,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SplashScreen();
  }
}
