import 'package:greenminds/network/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> confirmAcount(String code) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Base.base + 'Account/ConfirmEmail?code=$code';
    final http.Response response =
        await http.post(url, headers: <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('token')}',
    });
    print(code);
    print(response.statusCode == 200);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw Exception(e);
  }
}
