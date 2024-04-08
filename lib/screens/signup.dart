import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:manage_product/screens/login.dart';
import 'package:manage_product/screens/products.dart';
import 'package:quickalert/quickalert.dart';

import '../modal/user.dart';
import '../req_handliing/user.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Center(
                  child: Column(
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Create your account",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  validator: (val) {
                    if (val == '') return 'This field is required.';
                    return null;
                  },
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                      hintText: 'Enter Full Name'),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val!.isEmpty) return 'This field is required.';
                    if (!EmailValidator.validate(val!)) {
                      return 'Please enter valid Email Id';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter Email Id'),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: mobileController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == '') return 'This field is required.';
                    return null;
                  },
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Mobile No.',
                      hintText: 'Enter Mobile No.'),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: passwordController,
                  maxLength: 10,
                  validator: (val) {
                    if (val == '') return 'This field is required.';
                    return null;
                  },
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password'),
                ),
                const SizedBox(height: 30),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var user = User(
                                nameController.text,
                                emailController.text,
                                mobileController.text,
                                passwordController.text);
                            Loader.show(context,progressIndicator:CircularProgressIndicator());
                            var res = await UserHTTPRequest.createUser(user);
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
                                  Navigator.pop(context);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const ProductPage()));
                                },
                                context: context,
                                type: QuickAlertType.success,
                                text: res.message,
                              );
                            }
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Sign Up",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ))),
                const SizedBox(height: 30),
                Center(
                  child: Text.rich(TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(fontSize: 18),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )
                      ])),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
