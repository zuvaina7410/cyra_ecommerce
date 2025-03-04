import 'dart:convert';
import 'dart:developer';

import 'package:cyra_ecommerce_project/constants.dart';
import 'package:cyra_ecommerce_project/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String? name, phone, address, username, password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  registration(String? name, phone, address, username, password) async {
    log("...........Web Service..........");
    log("name = " + name.toString());
    log("phone = " + phone.toString());
    log("address = " + address.toString());
    log("username = " + username.toString());
    log("password = " + password.toString());

    var result;
    final Map<String, dynamic> RegData = {
      'name': name,
      'phone': phone,
      'address': address,
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse("http://bootcamp.cyralearnings.com/registration.php"),
      body: RegData,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body.contains("success")) {
        log("registration successfully completed");

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
      } else {
        log("registration failed");
      }
    } else {
      result = {log(json.decode(response.body)['error'].toString())};
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  " Register Account ",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(" Complete your details "),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TextFormField(
                                onChanged: (text) {
                                  setState(() {
                                    name = text;
                                  });
                                },
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Name',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your name';
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TextFormField(
                                onChanged: (text) {
                                  setState(() {
                                    phone = text;
                                  });
                                },
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your phone';
                                  } else if (value.length > 10 ||
                                      value.length < 10) {
                                    return 'Please enter valid phone number';
                                  }
                                },
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Phone',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TextFormField(
                                maxLines: 4,
                                onChanged: (text) {
                                  setState(() {
                                    address = text;
                                  });
                                },
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Address',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your address';
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TextFormField(
                                onChanged: (text) {
                                  setState(() {
                                    username = text;
                                  });
                                },
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Username',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your username';
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: TextFormField(
                                onChanged: (text) {
                                  setState(() {
                                    password = text;
                                  });
                                },
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Password',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your password';
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white, shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: maincolor,
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  log("name = " + name.toString());
                                  log("phone = " + phone.toString());
                                  log("address = " + address.toString());
                                  log("username = " + username.toString());
                                  log("password = " + password.toString());
                                  registration(
                                      name, phone, address, username, password);
                                }
                              },
                              child: Text(
                                "Register",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do you have an account?",
                            style: TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LoginPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                color: maincolor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
