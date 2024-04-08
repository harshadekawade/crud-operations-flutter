class APIPath{
  static String baseUrl = "https://shareittofriends.com/demo/flutter";
  static String register = "/Register.php";
  static String login = "/Login.php";
  static String productList = "/productList.php";
  static String addProduct = "/addProduct.php";
  static String editProduct = "/editProduct.php";
  static String deleteProduct = "/deleteProduct.php";
}

class ResponseMessageHandle {
  String status = 'error';
  late String message;

  ResponseMessageHandle(this.status, this.message);
}