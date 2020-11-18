import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../HelperClasses/authenticate.dart';

import '../HelperClasses/authenticate.dart';
import '../HelperClasses/database.dart';
import '../ObjectClasses/appInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../HelperClasses/group_label.dart';
import '../ObjectClasses/group.dart';

import './home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  AuthService authService = new AuthService();
  DatabaseService databaseService = new DatabaseService();

  String _email;
  String _password;
  bool _loading = false;

  AppInfo appInfo = new AppInfo();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // creates text form field for user to enter their email in
    final email = TextFormField(
      obscureText: false,
      style: TextStyle(color: Color(0xff27b4c3)),
      decoration: InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(color: Color(0xff27b4c3)),
          labelStyle: TextStyle(color: Color(0xff27b4c3))),
      validator: (value) {
        // if user doesn't enter in an email, login page prompts for an email
        if (value.isEmpty) {
          return 'Please enter your email!';
        }
        return null;
      },
      onSaved: (input) {
        _email = input;
      },
    );
    // creates text form field for user to enter their password in
    final password = TextFormField(
      obscureText: true,
      style: TextStyle(color: Color(0xff27b4c3)),
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(color: Color(0xff27b4c3)),
      ),
      validator: (value) {
        // prompts user for password if they leave the field empty
        if (value.isEmpty) {
          return 'Please enter your password!';
        }
        return null;
      },
      onSaved: (input) {
        _password = input;
      },
    );

    // user presses login button to begin backend authentication process
    final loginBtn = new SizedBox(
        width: 100,
        height: 30,
        child: new RaisedButton(
          onPressed: () {
            final form = _formKey.currentState;
            form.save();

            if (form.validate()) {
              setState(() {
                _loading = true;
              });
            }

            authService
                .signInWithEmailAndPassword(_email, _password)
                .then((val) {
              databaseService.getUserByEmail(_email).then((result) {
                QuerySnapshot userSnapshot;
                userSnapshot = result;

                dynamic dynamicUsername =
                    userSnapshot.docs[0].data()["username"];
                String username = dynamicUsername;

                appInfo.username = username;
              });

              if (val != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(appInfo: appInfo)));
              } else {
                // unsuccessful Login
                setState(() {
                  _loading = false;
                });
              }
            });
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          padding: EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff27b4c3), Color(0xff84dfa0)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              constraints: BoxConstraints(maxWidth: 100.0, minHeight: 10.0),
              alignment: Alignment.center,
              child: Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ));

    // user can press signup button to navigate to the signup page
    final signUpBtn = new SizedBox(
        width: 100,
        height: 30,
        child: new RaisedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/signup');
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          padding: EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff27b4c3), Color(0xff84dfa0)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              constraints: BoxConstraints(maxWidth: 100.0, minHeight: 10.0),
              alignment: Alignment.center,
              child: Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ));
    // user can also sign in through google
    final googleSignInBtn = new SizedBox(
      width: 150,
      height: 30,
      child: new RaisedButton(
        onPressed: () {
          getGroupData("mikeyhalim").then((result) {
            List<Group> groups;

            groups = result;

            groups.forEach((element) {
              print(element.name);
              print(element.groupID);
              print(element.description);
              print(element.adminID);
            });
          });
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff27b4c3), Color(0xff84dfa0)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 150.0, minHeight: 10.0),
            alignment: Alignment.center,
            child: Text(
              "Login with Google",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
      ),
    );
    // displays all of the elements of the home page altogether
    return Scaffold(
      backgroundColor: Colors.white,
      body: _loading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Center(
              child: Container(
                color: Colors.white,
                child: new Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // insert app logo here
                        Image.asset(
                          'images/HangEz Logo.png',
                          width: 200,
                          height: 200,
                        ),
                        // displaus each button and field
                        Flexible(flex: 2, child: email, fit: FlexFit.loose),
                        Flexible(flex: 2, child: password, fit: FlexFit.loose),
                        SizedBox(height: 10.0),
                        Flexible(flex: 2, child: loginBtn, fit: FlexFit.loose),
                        SizedBox(height: 10.0),
                        Flexible(
                            flex: 2,
                            child: googleSignInBtn,
                            fit: FlexFit.loose),
                        SizedBox(height: 10.0),
                        Flexible(flex: 2, child: signUpBtn, fit: FlexFit.loose),
                        SizedBox(height: 25.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
