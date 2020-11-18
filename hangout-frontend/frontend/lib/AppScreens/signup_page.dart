import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../HelperClasses/authenticate.dart';
import '../HelperClasses/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ObjectClasses/appInfo.dart';
import './home_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  bool loading = false;
  bool checkingUser = false;

  AppInfo appInfo = new AppInfo();

  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();

  final _formKey = new GlobalKey<FormState>();

  String userName;
  String email;
  String password;

  QuerySnapshot userSnapshot;
  checkUsername() {
    checkingUser = true;
    databaseService.getUserByUsername(userName).then(
      (val) {
        setState(
          () {
            userSnapshot = val;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Sign Up Page",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: loading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : ListView(
              children: [
                Container(
                  child: new Form(
                    key: _formKey,
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 16.0,
                        ),
                        // email is required from user
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.0, color: Color(0xff84dfa0))),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              // if user leaves email field empty, the page prompts the user for a response
                              if (value.isEmpty) {
                                return 'Please enter an email!';
                              }
                              return null;
                            },
                            // sets email to whatever the user types in the text form field
                            onChanged: (value) {
                              setState(
                                () {
                                  email = value;
                                },
                              );
                            },
                          ),
                        ),
                        // Username is required from user
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_add),
                              labelText: 'Username',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.0, color: Color(0xff84dfa0))),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              // if user leaves username field empty, the page prompts the user for a response
                              if (value.isEmpty) {
                                return 'Please enter a username!';
                              }
                              return null;
                            },
                            // sets username to whatever the user types in the text form field
                            onChanged: (value) {
                              setState(() {
                                userName = value;
                              });
                            },
                          ),
                        ),
                        // Password is required from user
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: TextFormField(
                            // hidden text while typing in password
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_searching),
                              labelText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.0, color: Color(0xff84dfa0))),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              // if user leaves password field empty, the page prompts the user for a response
                              if (value.isEmpty) {
                                return 'Please enter a password!';
                              }
                              return null;
                            },
                            // sets password to whatever the user types in the text form field
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: MaterialButton(
                            height: 45.0,
                            minWidth: 50.0,
                            color: Color(0xff27b4c3),
                            textColor: Colors.white,
                            // pressing Sign Up button initiates backend methods to create a new user
                            child: Text('Sign Up',
                                style: TextStyle(
                                  fontSize: 27,
                                )),
                            onPressed: () {
                              final form = _formKey.currentState;
                              form.save();
                              if (form.validate()) {
                                setState(() {
                                  loading = true;
                                });

                                // checks if username is available
                                databaseService
                                    .getUserByUsername(userName)
                                    .then((result) {
                                  QuerySnapshot userSnapshot;
                                  userSnapshot = result;

                                  print(userSnapshot == null);

                                  // conditional for username availability
                                  bool isAvailable = result != null
                                      ? userSnapshot.docs.length == 0
                                      : false;

                                  if (isAvailable) {
                                    authService
                                        .signUpWithEmailAndPassword(
                                            email, password)
                                        .then((val) {
                                      print(val);

                                      if (val != null) {
                                        //Success!

                                        Map<String, String> userMap = {
                                          "username": userName,
                                          "email": email
                                        };

                                        databaseService
                                            .postUserDetails(userMap);

                                        appInfo.username = userName;

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomePage(
                                                    appInfo: appInfo)));
                                      } else {
                                        print(
                                            "Account already registered with that email or username");

                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                    });
                                  } else {
                                    print(
                                        "Account already registered with that username");

                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
