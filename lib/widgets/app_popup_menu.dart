import 'package:flutter/material.dart';
import 'package:greenminds/screen/account.dart';
import 'package:greenminds/screen/my_products.dart';
import 'package:greenminds/screen/splash.dart';
import 'package:greenminds/themes/app_utilities.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPopUpMenu extends StatefulWidget {
  @override
  _AppPopUpMenuState createState() => _AppPopUpMenuState();
}

class _AppPopUpMenuState extends State<AppPopUpMenu> {
  int _selectedValue;
  final List<PopupMenuItem<int>> _menuItems = [
    PopupMenuItem(
      child: Text('profile'),
      value: 1,
    ),
    PopupMenuItem(
      child: Text('logout'),
      value: 2,
    ),
  ];

  PopupMenu menu;
  bool _isShow = false;
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  GlobalKey btnKey3 = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) async {
    print('Click menu -> ${item.menuTitle}');
    switch (item.menuTitle) {
      case 'log out':
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isAllowedToLogin', false);
        prefs.setString('user', '');
        prefs.setString('pass', '');
        prefs.setString('token', '');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SplashScreen()));
        break;
      case 'My Products':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyProductsScreen()));
        break;
      case 'Account':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AccountScreen()));
        break;
      default:
    }
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    return InkWell(
      onTap: maxColumn,
      child: Container(
        padding: EdgeInsets.all(8.0),
        key: btnKey,
        child: Icon(
          Icons.account_circle,
          size: 32,
        ),
      ),
    );
  }

  void maxColumn() {
    menu = PopupMenu(
        backgroundColor: AppUtilities.appBlue,
        lineColor: AppUtilities.appBlue,
        items: [
          MenuItem(
              title: 'Account',
              image: Icon(
                Icons.account_circle,
                color: Colors.white,
              )),
          MenuItem(
              title: 'My Products',
              image: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
          MenuItem(
              title: 'log out',
              image: Icon(
                Icons.input,
                color: Colors.white,
              )),
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey);
  }
}

/*
PopupMenuButton<int>(
      onCanceled: () {
        print('cancel');
      },
      onSelected: (int value) {
        _selectedValue = value;
        print(value);
      },
      itemBuilder: (context) => _menuItems,
      color: AppUtilities.appGreen,
      
    );
*/
