import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../HelperClasses/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ObjectClasses/appInfo.dart';

class CreateGroupPage extends StatefulWidget {
  final AppInfo appInfo;

  CreateGroupPage({Key key, this.title, @required this.appInfo})
      : super(key: key);
  final String title;
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroupPage> {
  // method to create a popup when user succcesfully creates a group
  _buildDialog(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: new Text(text),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            actions: <Widget>[
              new FlatButton(
                // exits popup when pressed
                onPressed: () {
                  Navigator.of(context).pop();
                },
                textColor: Theme.of(context).primaryColor,
                child: const Text('Okay, got it!'),
              ),
            ],
          );
        });
  }

  // variables to be used
  final _formKey = new GlobalKey<FormState>();
  String groupName;
  String groupDescription;
  String groupCode;

  DatabaseService databaseService = new DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // display app bar at top of screen
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Create Group",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),

      // create list view so fields display in a simple vertical layout
      body: ListView(
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    // text field for entering group name
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.label),
                        labelText: 'Group Name',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3.0, color: Color(0xff84dfa0))),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a group name!';
                        }
                        return null;
                      },
                      // update the group name based on input
                      onChanged: (value) {
                        setState(
                          () {
                            groupName = value;
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    // a text field to enter group description
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.description),
                        labelText: 'Group Description',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3.0, color: Color(0xff84dfa0))),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a group description!';
                        }
                        return null;
                      },
                      // update group description with information
                      onChanged: (value) {
                        setState(
                          () {
                            groupDescription = value;
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    // text field for the group code
                    child: TextFormField(
                      // limit the code to 6 characters
                      maxLength: 6,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.group),
                        labelText: '6 Digit Group Code',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3.0, color: Color(0xff84dfa0))),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a group code!';
                        }
                        return null;
                      },
                      // update the group code
                      onChanged: (value) {
                        setState(
                          () {
                            groupCode = value;
                          },
                        );
                      },
                    ),
                  ),
                  // create group button
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
                    child: MaterialButton(
                      height: 45.0,
                      minWidth: 50.0,
                      color: Color(0xff27b4c3),
                      textColor: Colors.white,
                      child: Text(
                        'Create Group',
                        style: TextStyle(
                          fontSize: 27,
                        ),
                      ),
                      onPressed: () {
                        final form = _formKey.currentState;
                        form.save();
                        if (form.validate()) {
                          print('Submit form!');

                          databaseService.getGroupByCode(groupCode).then(
                            (result) {
                              QuerySnapshot groupSnapshot;
                              groupSnapshot = result;

                              bool isAvailable = result != null
                                  ? groupSnapshot.docs.length == 0
                                  : false;

                              if (isAvailable) {
                                String username = widget.appInfo.username;

                                print(username);

                                databaseService.postGroupToGroupCollection(
                                    username,
                                    groupCode,
                                    groupName,
                                    groupDescription);
                                databaseService.postGroupToUser(
                                    username, groupCode);

                                print('Successfully created group "' +
                                    groupName +
                                    '"');
                                _buildDialog(
                                    context, 'Successfully created group');

                                //Navigate to page
                                AppInfo appInfo = new AppInfo(
                                    username: username,
                                    currentGroupCode:
                                        groupCode); // Pass this to the new page

                              } else {
                                print("Group with that code already exists!");
                              }
                            },
                          );
                        }
                        Navigator.of(context).pop();
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
