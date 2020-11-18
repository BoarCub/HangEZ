import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../ObjectClasses/user.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_auth/firebase_auth.dart" as fbAuth;
import "package:frontend/prefabs/userprefab.dart";

/*
 * Object Name: AuthService()
 * 
 * Developer: Deepayan Sanyal
 * 
 * Description: This class contains utility methods to authenticate the user, including signup and signin functionality
 * 
 * Implementation:
 *  - Firebase, which includes packages for authentication which we use here
 *  - Calls the Firebase backend service that was configured
 * 
 * Dependencies: Firebase must be correctly configured in Flutter
 * 
*/

class AuthService with ChangeNotifier {

  AuthService();

  Future getUser() {
    return Future.value("Hello");
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserPrefab _user(fbAuth.User user){
    return user != null ? UserPrefab(id: user.uid) : null;
  }

  //Used to login with an existing email and password
  //Input: email<String>, password<String>
  //Result: Verifies the login was valid, and returning a user object if it was
  Future<UserPrefab> signInWithEmailAndPassword(String email, String pass) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword (email: email, password: pass);
      
      fbAuth.User firebaseUser = result.user;
      return _user(firebaseUser);

    } catch(e) {
      print(e.toString());
    }
  }

  //Used to signup when registering a new account
  //Input: email<String>, password<String>
  //Result: Registers the user if no user is already registered with that email, returning the user object is successful
  Future signUpWithEmailAndPassword(String email, String pass) async{
    try{
       UserCredential result = await _auth.createUserWithEmailAndPassword (email: email, password: pass);
      
      fbAuth.User firebaseUser = result.user;
      return _user(firebaseUser);
    } 
      catch (e){
      print(e.toString());
    }
  }

  //Used to reset the user's password
  //Input: email<String>
  //Result: Sends an email to the user to reset their password via Firebase services
  Future resetPass(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e){
      print(e.toString());
    }
  }

}
