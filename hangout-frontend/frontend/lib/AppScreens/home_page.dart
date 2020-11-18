import 'package:flutter/material.dart';
import 'account_drawer.dart';
import 'group_drawer.dart';
import '../ObjectClasses/appInfo.dart';
import '../HelperClasses/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './create_group.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.appInfo}) : super(key: key);
  final AppInfo appInfo;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String enteredText;
  bool loading = false;
  DatabaseService databaseService = new DatabaseService();

  // method to build a dialog for joining/creating group
  buildDialog(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: new Text(text),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              /*children: <Widget>[
                Text('Succesfully Joined Group'),
              ],*/
            ),
            actions: <Widget>[
              new FlatButton(
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

  // method to create a popup button
  createAlertDialog(BuildContext context, String text) {
    Widget submitButton = MaterialButton(
      elevation: 5.0,
      child: Text(
        "Submit",
        style: TextStyle(
          color: Color(0xff27b4c3),
        ),
      ),
      onPressed: () {
        // exit popup
        Navigator.of(context).pop();
        // Join Group
        print(enteredText);
        String groupcode =
            enteredText; // Hardcoded for now for testing purposes, please update

        databaseService.getUserByUsername(appInfo.username).then((userDoc) {
          QuerySnapshot userSnapshot;
          userSnapshot = userDoc;

          String userDocId = userSnapshot.docs[0].id;

          databaseService
              .checkGroupOfUserById(userDocId, groupcode)
              .then((result) {
            QuerySnapshot groupsSnapshot;
            groupsSnapshot = result;

            bool joinedGroup =
                result != null ? groupsSnapshot.docs.length > 0 : false;

            if (!joinedGroup) {
              databaseService.getGroupByCode(groupcode).then((value) {
                QuerySnapshot groupSnapshot;
                groupSnapshot = value;
                bool groupEmpty =
                    value != null ? groupSnapshot.docs.length == 0 : false;

                if (!groupEmpty) {
                  databaseService.postGroupToUser(appInfo.username, groupcode);

                  // Success!

                  print('Successfully joined group');
                  buildDialog(context, 'Successfully joined group');
                } else {
                  //Group doesn't exist
                  print("Group Doesn't Exist");
                  buildDialog(context, "Group Doesn't Exist");
                }
              });
            } else {
              //User Already In Group
              print("User Is Already In This Group");
              buildDialog(context, "User Is Already In This Group");
            }
          });
        });
      },
    );
    // exits out of the pop up
    Widget cancelButton = MaterialButton(
      elevation: 5.0,
      child: Text(
        'Cancel',
        style: TextStyle(
          color: Color(0xff27b4c3),
        ),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
    // allows text to be entered
    TextEditingController customController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentTextStyle: TextStyle(
            color: Color(0xff27b4c3),
          ),
          title: Text(text),
          content: TextField(
            maxLength: 6,
            controller: customController,
            onChanged: (newText) {
              enteredText = newText;
            },
          ),
          actions: <Widget>[
            submitButton,
            cancelButton,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //future: Provider.of<AuthService>(context).getUser(),
      builder: (context, snapshot) {
        //if (snapshot.connectionState == ConnectionState.done) {
        return Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              /*ARElements(
                user: snapshot.data,
              ),*/
              Align(
                child: Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('images/App Background2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Display account drawer button
              Positioned(
                  left: 20,
                  bottom: 20,
                  child: Container(
                      child: new IconButton(
                    onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    icon: Icon(Icons.account_circle),
                    color: Color(0xff27b4c3),
                    iconSize: 72.0,
                  ))),
              // Display group drawer button
              Positioned(
                  right: 20,
                  bottom: 20,
                  child: Container(
                      child: new IconButton(
                    onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
                    icon: Icon(Icons.group),
                    color: Color(0xff27b4c3),
                    iconSize: 72.0,
                  ))),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  height: 70,
                  child: RaisedButton(
                    //onPressed: () => Navigator.of(context).pushNamed('/poll'),
                    onPressed: () =>
                        createAlertDialog(context, 'Enter Group Code'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff27b4c3), Color(0xff84dfa0)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Join Group",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Display create group button
              Align(
                alignment: Alignment(0.0, -0.27),
                child: Container(
                  width: 300,
                  height: 70,
                  // Add functionality
                  child: RaisedButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed('/createGroup');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreateGroupPage(appInfo: appInfo)));
                    },
                    // Gradient design
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff27b4c3), Color(0xff84dfa0)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Create Group",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Display helpful text
              Align(
                alignment: Alignment(0.0, 0.30),
                child: Container(
                  child: new Text(
                    'Lost? Check out the FAQ section\non the left sidebar for help.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xff27b4c3),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          drawer: new AccountDrawer(
              //user: snapshot.data,
              ),
          endDrawer: new GroupDrawer(
            userID: appInfo.username,
          ),
        );
        //} else {
        // return CircularProgressIndicator();
        //}
      },
    );
  }
}
