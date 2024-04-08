class Product{
  late String id;
  late String name;
  late String price;
  late String moq;
  late String discountPrice;

  Product({required this.id, required this.name, required this.price, required this.moq, required this.discountPrice});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    moq = json['moq'];
    discountPrice = json['discounted_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['moq'] = moq;
    data['discounted_price'] = discountPrice;
    return data;
  }
}