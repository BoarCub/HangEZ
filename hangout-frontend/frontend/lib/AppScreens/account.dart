import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:frontend/classes_and_methods/authenticate.dart';
class AccountPage extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

// have to retain other settings that the user doesn't update
class _AccountState extends State<AccountPage> {
  final _formKey = new GlobalKey<FormState>();
  String userName;
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Align(
              alignment: Alignment.center,
              child: Text(
                "Update Account Information",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ))),
      // create a list view that displays all the fields in a simple, vertically aligned format
      body: ListView(
        children: [
          Container(
            child: new Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        // add text field for email input
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.0, color: Color(0xff84dfa0))),
                              border: OutlineInputBorder(),
                            ),
                            // update value of email
                            onChanged: (value) {
                              setState(
                                () {
                                  email = value;
                                },
                              );
                            },
                          ),
                        ),
                        // add spacing
                        SizedBox(width: 16),
                        // add button to update the account settings
                        MaterialButton(
                          height: 50.0,
                          minWidth: 45.0,
                          color: Color(0xff27b4c3),
                          textColor: Colors.white,
                          child: Text('Update',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          // save the updated information
                          onPressed: () {
                            final form = _formKey.currentState;
                            form.save();
                            if (form.validate()) {
                              print('Submit form!');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        // add field for username
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_add),
                              labelText: 'Username',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.0, color: Color(0xff84dfa0))),
                              border: OutlineInputBorder(),
                            ),
                            // update username with new string
                            onChanged: (value) {
                              setState(
                                () {
                                  userName = value.toString();
                                },
                              );
                            },
                          ),
                        ),
                        // add spacing
                        SizedBox(width: 16),
                        MaterialButton(
                          height: 50.0,
                          minWidth: 45.0,
                          color: Color(0xff27b4c3),
                          textColor: Colors.white,
                          child: Text('Update',
                              style: TextStyle(
                                fontSize: 30,
                              )),
                          // save new username value
                          onPressed: () {
                            final form = _formKey.currentState;
                            form.save();
                            if (form.validate()) {
                              print('Submit form!');
                            }
                          },
                        ),
                      ],
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
