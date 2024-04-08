class User{
  late String name;
  late String email;
  late String mobile;
  late String password;

  User(this.name, this.email, this.mobile, this.password);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['password'] = email;
    return data;
  }
}