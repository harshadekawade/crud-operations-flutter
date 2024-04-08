import 'dart:convert';

import 'package:http/http.dart';
import 'package:manage_product/api.dart';
import 'package:manage_product/modal/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHTTPRequest {
  static Future createUser(User user) async {
    String url = APIPath.baseUrl + APIPath.register;

    try {
      Response res = await post(Uri.parse(url), body: user.toJson());
      var jsonRes = json.decode(res.body);
      if (res.statusCode == 200) {
        var data = jsonRes["data"];
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("user_token", data["user_token"]);

        // pref.setString("user_token", "c2a2f674c6f6a1d2374da1ebfab69adc");
        pref.setString("name", data["name"]);
        pref.setString("mobile", data["mobile"]);
        pref.setString("email", data["email"]);
        return ResponseMessageHandle("success", jsonRes["message"]);
      } else {
        return ResponseMessageHandle("error", jsonRes["message"]);
      }
    } on Exception catch (e) {
      return ResponseMessageHandle("error", "Internal server error");
    }
  }

  static Future verifyUser(String username, String password) async {
    String url = APIPath.baseUrl + APIPath.login;

    try {
      Response res = await post(Uri.parse(url),
          body: {"email": username, "password": password});
      var jsonRes = json.decode(res.body);
      if (res.statusCode == 200) {
        var data = jsonRes["data"];
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("user_token", data["user_token"]);
        // pref.setString("user_token", "c2a2f674c6f6a1d2374da1ebfab69adc");
        pref.setString("name", data["name"]);
        pref.setString("mobile", data["mobile"]);
        pref.setString("email", data["email"]);
        return ResponseMessageHandle("success", jsonRes["message"]);
      } else {
        return ResponseMessageHandle("error", jsonRes["message"]);
      }
    } on Exception catch (e) {
      return ResponseMessageHandle("error", "Internal server error");
    }
  }
}
