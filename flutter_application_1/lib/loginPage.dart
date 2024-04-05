import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Information.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'userHomePage.dart';
import 'singUpPage.dart';

class IpAddress {
  String _ipAddress = 'Unknown';

  Future<String> _getIpAddress() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // Get the IP address of the mobile network
      var ipAddress = await _getMobileIpAddress();

      _ipAddress = ipAddress ?? 'Unknown';
      return _ipAddress;
    } else {
      _ipAddress = 'Not connected to a mobile network';
      return "emulator";
    }
  }

  Future<String?> _getMobileIpAddress() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.address.isNotEmpty && !addr.address.startsWith('127.')) {
          return addr.address;
        }
      }
    }
    return null;
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State createState() => _LoginState();
}

class _LoginState extends State {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<bool> loginInfoIsCorrect() async {
    String ipAdress = await IpAddress()._getIpAddress();

    if (_formKey.currentState!.validate()) {
      String url = 'http://prasad25.pythonanywhere.com//login';
      Map<String, String> headers = {'Content-Type': 'application/json'};
      Map<String, String> body = {
        'username': usernameController.text,
        'password': passwordController.text,
        'ipAdress': ipAdress,
      };

      try {
        print("here here");
        final response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(body));

        if (response.statusCode == 200) {
          print('Login successful');

          setState(() {});
          return true;
          // Navigate to next screen or perform necessary actions
        } else {
          print("here");
          print('Login failed: ${response.reasonPhrase}');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            animation: kAlwaysCompleteAnimation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            content:
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Username or password is wrong !",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.5,
                ),
              ),
            ]),
            backgroundColor: Color.fromARGB(255, 255, 133, 124),
          ));
          setState(() {});

          return false;
        }
      } catch (error) {
        print('Error: $error');
      }
    }
    return false;
  }

  Future<void> login() async {
    if (await loginInfoIsCorrect()) {
      Information.getDataObject().setInfo(
          username: usernameController.text, password: passwordController.text);

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (context, animation, _) {
            return FadeTransition(
              opacity: animation,
              child: const HomePage(),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Image.asset(
                "assets/images/user.png",
                height: 160,
                width: 160,
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                'Login as a Teacher',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "SF UI Text",
                    letterSpacing: 0.4),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username ';
                            } /*else if (!EmailValidator.validate(value)) {
                      return 'Please enter proper mail';
                    }*/
                            return null;
                          },
                          controller: usernameController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 95, 78, 244),
                                      width: 1.5)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black12)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide:
                                      BorderSide(color: Colors.red.shade800)),
                              prefixIcon: const Icon(
                                Icons.person,
                                //color: Colors.orange,
                              ),
                              labelText: 'Username',
                              labelStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromRGBO(0, 0, 0, 0.6)),
                              fillColor:
                                  const Color.fromARGB(255, 231, 233, 238),
                              filled: true),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password ';
                            } /*else if (!EmailValidator.validate(value)) {
                      return 'Please enter proper mail';
                    }*/
                            return null;
                          },
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 13.0, horizontal: 10.0),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 95, 78, 244),
                                      width: 1.5)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 80, 78, 78))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide:
                                      BorderSide(color: Colors.red.shade800)),
                              prefixIcon: const Icon(Icons.key),
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromRGBO(0, 0, 0, 0.6)),
                              fillColor:
                                  const Color.fromARGB(255, 231, 233, 238),
                              filled: true),
                        ),
                      )
                    ],
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(
                  width: 150,
                ),
                TextButton(
                  onPressed: () {},
                  style: const ButtonStyle(),
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                      letterSpacing: (0.5),
                      color: Color.fromARGB(221, 27, 27, 27),
                      fontSize: 15,
                    ),
                  ),
                )
              ]),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                  width: 300,
                  height: 43,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 14,
                        offset: const Offset(2, 8))
                  ]),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 144, 120, 255),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: login,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  )),
              const SizedBox(
                height: 30.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: createNewAccount,
                  style: const ButtonStyle(),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: Color.fromARGB(255, 144, 120, 255),
                      fontSize: 18,
                    ),
                  ),
                )
              ]),

              /* Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  "Are you a Admin?",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {},
                  style: const ButtonStyle(),
                  child: Text(
                    "Click here",
                    style: TextStyle(
                      color: Colors.amber.shade800,
                      fontSize: 18,
                    ),
                  ),
                )
              ]),*/
            ],
          ),
        ),
      ),
    ));
  }

  void createNewAccount() {
    usernameController.clear();
    passwordController.clear();
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, _) {
          return FadeTransition(
            opacity: animation,
            child: const NewAccount(),
          );
        },
      ),
    );
  }
}
