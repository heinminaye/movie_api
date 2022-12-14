import 'dart:convert';

import 'package:api/view/sign_up.dart';

import '../main.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final pref = SharedPreferences.getInstance();
  bool eye = true;

  bool _checkVal = false;

  void _submit() async {
    if (_errorText == null && _errorUserText == null) {
      try {
        final _auth = FirebaseAuth.instance;

        UserCredential currentUser = await _auth.signInWithEmailAndPassword(
            email: usernameController.text, password: passwordController.text);

        Navigator.pushReplacementNamed(context, '/homePage');
      } catch (e) {
        var snackBar = SnackBar(
          duration: const Duration(milliseconds: 1500),
          content:
              Text('${e.toString().replaceRange(0, 14, '').split(']')[1]}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // if (username == usernameController.text &&
      //     password == passwordController.text) {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => MyHomePage()));
      // } else {
      //   const snackBar = SnackBar(
      //     duration: Duration(milliseconds: 1500),
      //     content: Text('Login Failed'),
      //   );
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // }
    }
  }

  String? get _errorUserText {
    if (usernameController.value.text.isEmpty) {
      return "Can't be empty";
    }
    return null;
  }

  String? get _errorText {
    if (passwordController.value.text.isEmpty) {
      return "Can't be empty";
    }
    return null;
  }

  bool check = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _text = '';
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: (Row(
            children: [
              Row(
                children: [
                  IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Sing In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              ),
            ],
          )),
        ),
        backgroundColor: Colors.black,
        body: Center(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Username",
                  errorText: _checkVal ? _errorUserText : null,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.white70,
                  ),
                  hintText: "Enter your username",
                  hintStyle: const TextStyle(color: Colors.white38),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Color.fromARGB(255, 177, 177, 177)),
                  ),
                ),
                onChanged: (text) => setState(() => _text),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: passwordController,
                obscureText: eye,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    errorText: _checkVal ? _errorText : null,
                    labelText: "Password",
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white70,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 177, 177, 177)),
                    ),
                    suffixIcon: IconButton(
                        splashRadius: 5,
                        iconSize: 20,
                        onPressed: () {
                          setState(() {
                            eye = !eye;
                          });
                        },
                        icon: eye
                            ? const Icon(
                                Icons.remove_red_eye,
                                color: Colors.white54,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.white54,
                              ))),
                onChanged: (text) => setState(() => _text),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          setState(() {
                            if (_checkVal == true) {
                              _submit();
                            } else {
                              _checkVal = true;
                            }
                          });
                        });
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ))),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white60),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ))),
      ),
    );
  }
}
