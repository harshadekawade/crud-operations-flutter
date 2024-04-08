import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manage_product/modal/product.dart';
import 'package:manage_product/req_handliing/product.dart';
import 'package:manage_product/screens/login.dart';
import 'package:manage_product/screens/screen1.dart';
import 'package:manage_product/screens/screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickalert/quickalert.dart';
import '../req_handliing/user.dart';

import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<SharedPreferences> userPref;

  @override
  void initState() {
    userPref = SharedPreferences.getInstance().then((prefs) {
      return prefs;
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController moqController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideDrawer(context),
      appBar: AppBar(
        title: const Text("Manage Products", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Product>>(
        future: ProductHTTPRequest.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDialogue(context,
                          product: snapshot.data![index], isAddForm: false);
                    },
                    child: ListTile(
                      leading: Image.asset("assets/images/defproduct.png"),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data![index].name.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.currency_rupee,
                                  size: 18, color: Colors.grey),
                              Text(
                                snapshot.data![index].price.toString(),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          showConfirmDialogue(
                              context, snapshot.data![index].id);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogue(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future showDialogue(BuildContext con, {isAddForm = true, Product? product}) {
    nameController.clear();
    priceController.clear();
    discountPriceController.clear();
    moqController.clear();
    if (!isAddForm) {
      nameController.text = product!.name;
      priceController.text = product.price;
      discountPriceController.text = product.discountPrice;
      moqController.text = product.moq;
    }
    return showDialog(
        context: con,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: (val) {
                            if (val == '') return 'This field is required';
                            return null;
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Product Name',
                              hintText: 'Enter Name'),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: priceController,
                          validator: (val) {
                            if (val == '') return 'This field is required';
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Price',
                              hintText: 'Enter Price'),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: discountPriceController,
                          validator: (val) {
                            if (val == '') return 'This field is required';
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Discount Price',
                              hintText: 'Enter Price'),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: moqController,
                          validator: (val) {
                            if (val == '') return 'This field is required';
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Minimum Order Qty',
                              hintText: 'Enter Qty'),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Product p = Product(
                                      id: !isAddForm ? product!.id : '',
                                      name: nameController.text,
                                      price: priceController.text,
                                      moq: moqController.text,
                                      discountPrice:
                                      discountPriceController.text);
                                  Loader.show(context,progressIndicator:CircularProgressIndicator());
                                  var res = await ProductHTTPRequest.addEditProduct(
                                      p, isAddForm);
                                  Loader.hide();
                                  if (res.status == 'error')
                                  {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text: res.message,
                                    );
                                  }
                                  else
                                  {
                                    QuickAlert.show(
                                      onConfirmBtnTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) => ProductPage(),
                                          ),
                                        );
                                      },
                                      context: context,
                                      type: QuickAlertType.success,
                                      text: res.message,
                                    );
                                  }
                                }
                              },
                              child: Text(
                                isAddForm ? 'Add' : 'Update',
                                style: const TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.grey),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                setState((){});
                              },
                              child: const Text(
                                "Close",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  )),
              title: Text('${isAddForm ? 'Add' : 'Edit'} Product'),
            );
          });
        });
  }

  Future showConfirmDialogue(BuildContext con, pid) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.grey),
      ),
      child: const Text("Cancel", style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      child: const Text("Continue", style: TextStyle(color: Colors.white)),
      onPressed: () async {
        Navigator.pop(context);
        Loader.show(context,progressIndicator:CircularProgressIndicator());
        var res = await ProductHTTPRequest.deleteProduct(pid);
        Loader.hide();
        if (res.status == 'error')
        {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: res.message,
          );
        }
        else
        {
          QuickAlert.show(
            onConfirmBtnTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ProductPage(),
                ),
              );
            },
            context: context,
            type: QuickAlertType.success,
            text: res.message,
          );
        }
      },
    );
    return showDialog(
        context: con,
        builder: (context) {
          return AlertDialog(
            content: Text("Are you sure want to delete?"),
            actions: [
              cancelButton,
              continueButton,
            ],
            title: Text('Confirm'),
          );
        });
  }

  Widget sideDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text('Manage Products',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                FutureBuilder<SharedPreferences>(
                    future: userPref,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        // The value is not read yet
                        return Text("Loading username...");
                      }
                      final prefs = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(prefs!.getString('name').toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          Text(prefs!.getString('email').toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          Text(prefs!.getString('mobile').toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ],
                      );
                    }),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Theme.of(context).primaryColor),
            title: Text(
              'Home',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: const Text('Screens'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.sticky_note_2_rounded,
              color: Colors.grey,
            ),
            title: const Text(
              'Screen1',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Screen1()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.sticky_note_2_rounded,
              color: Colors.grey,
            ),
            title: const Text(
              'Screen2',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Screen2()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.grey,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
