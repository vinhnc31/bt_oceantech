import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../servites/auth_servites.dart';
import '../widget/text_input.dart';
import 'login.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Regiter extends StatefulWidget {
  const Regiter({super.key});

  @override
  State<Regiter> createState() => _regiterState();
}

class _regiterState extends State<Regiter> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  final AuthServices _auth = AuthServices();

  void signUp() async {
    String fullName = _fullNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }
    EasyLoading.show(status: 'loading...');
    User? user = await _auth.signUp(fullName, email, password);
    if (user != null) {
      EasyLoading.showToast('SignUp successfully');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      EasyLoading.showToast('SignUp fail');
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 130,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "REGISTER",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextInput(
                            controller: _fullNameController,
                            labelText: 'Full name',
                            hintText: "Enter the full name",
                            prefixIcon: Icon(Icons.person),
                            textInputType: TextInputType.text,
                            isShowpassword: false,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return "FullName cannot be empty";
                              }
                            },
                            // other parameters...
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextInput(
                            controller: _emailController,
                            labelText: 'Email',
                            hintText: "Enter the email",
                            prefixIcon: Icon(Icons.email),
                            textInputType: TextInputType.text,
                            isShowpassword: false,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return "Email cannot be empty";
                              }
                              final pattern =
                                  r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
                              final regExp = RegExp(pattern);
                              if (!regExp.hasMatch(value!)) {
                                return "Email is in wrong format";
                              }
                            },
                            // other parameters...
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextInput(
                            controller: _passwordController,
                            labelText: 'Password',
                            hintText: "Enter the password",
                            prefixIcon: Icon(Icons.password),
                            textInputType: TextInputType.text,
                            isShowpassword: true,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return "Password cannot be empty";
                              }
                            },
                            // other parameters...
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextInput(
                            controller: _confirmPasswordController,
                            labelText: 'Confirm Password',
                            hintText: "Enter the confirm password",
                            prefixIcon: Icon(Icons.password),
                            textInputType: TextInputType.text,
                            isShowpassword: true,
                            validator: (String? value) {
                              if (value != null && value.isEmpty) {
                                return "FullName cannot be empty";
                              }
                              if (_confirmPasswordController !=
                                  _passwordController.text) {
                                return "Re-entered password does not match";
                              }
                            },
                            // other parameters...
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: signUp,
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "REGISTER",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Do you already have an account?",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login())),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ))
                            ],
                          )
                        ],
                      )),
                ))));
  }
}
