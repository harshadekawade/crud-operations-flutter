import 'dart:convert';

import 'package:http/http.dart';
import 'package:manage_product/api.dart';
import 'package:manage_product/modal/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/product.dart';

class ProductHTTPRequest {
  static Future<List<Product>> getProducts() async {
    String url = APIPath.baseUrl + APIPath.productList;

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var userToken = pref.getString("user_token");
      Response res =
          await post(Uri.parse(url), body: {"user_login_token": userToken});
      if (res.statusCode == 200) {
        List jsonResponse = json.decode(res.body);
        return jsonResponse.map((data) => Product.fromJson(data)).toList();
      } else if(res.statusCode == 404){
        throw json.decode(res.body)['message'];
      } else {
        throw "Unable to retrieve data.";
      }
    } on Exception catch (e) {
      throw "Unable to retrieve data.";
    }
  }

  static Future addEditProduct(Product product, isAddReqType) async {
    String url = APIPath.baseUrl + (isAddReqType ? APIPath.addProduct : APIPath.editProduct);

    try {
      Map<String,dynamic> productJson = product.toJson();
      SharedPreferences pref = await SharedPreferences.getInstance();
      var userToken = pref.getString("user_token");
      productJson["user_login_token"] = userToken;

      Response res = await post(Uri.parse(url), body: productJson);
      var jsonRes = json.decode(res.body);
      if (res.statusCode == 200) {
        return ResponseMessageHandle("success", jsonRes["message"]);
      } else {
        return ResponseMessageHandle("error", jsonRes["message"]);
      }
    } on Exception catch (e) {
      return ResponseMessageHandle("error", "Internal server error");
    }
  }

  static Future deleteProduct(pid) async {
    String url = APIPath.baseUrl + APIPath.deleteProduct;

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var userToken = pref.getString("user_token");

      Response res = await post(Uri.parse(url), body: {"user_login_token" : userToken, "id" : pid});
      var jsonRes = json.decode(res.body);
      if (res.statusCode == 200) {
        return ResponseMessageHandle("success", jsonRes["message"]);
      } else {
        return ResponseMessageHandle("error", jsonRes["message"]);
      }
    } on Exception catch (e) {
      return ResponseMessageHandle("error", "Internal server error");
    }
  }
}
