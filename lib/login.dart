import 'dart:convert';
import 'dart:developer';

import 'package:cyra_ecommerce_project/constants.dart';
import 'package:cyra_ecommerce_project/home.dart';
import 'package:cyra_ecommerce_project/registration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username, password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//............code part..............
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    log("isloggedin = " + isLoggedIn.toString());
    if (isLoggedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    }
  }

//login function
  login(String username, password) async {
    print("....Login Web Service.....");
    print(username);
    print(password);
    var result;
    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
        Uri.parse("http://bootcamp.cyralearnings.com/login.php"),
        body: loginData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body.contains("success")) {
        log("login successfully completed");
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        prefs.setString("username", username);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } else {
        log("login failed");
      }
    } else {
      result = {log(json.decode(response.body)['error'].toString())};
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    //.............In build,Only designing part..................
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Login with username and password \n",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xffE8E8E8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Username',
                          ),
                          onChanged: (text) {
                            setState(() {
                              username = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your username text';
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Password',
                          ),
                          onChanged: (text) {
                            setState(() {
                              password = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your password text';
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: maincolor,
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            log("username = " + username.toString());
                            log("password = " + password.toString());
                            login(username.toString(), password.toString());
                          }
                        },
                        child: Text(
                          "Login",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        log("go to registration");
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return RegistrationPage();
                          },
                        ));
                      },
                      child: Text(
                        "Go to Register",
                        style: TextStyle(
                            fontSize: 16,
                            color: maincolor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
