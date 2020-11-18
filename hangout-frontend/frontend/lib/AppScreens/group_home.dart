import 'package:flutter/material.dart';
import '../ObjectClasses/user.dart';
import '../ObjectClasses/group.dart';

class GroupPage extends StatefulWidget {
  GroupPage({Key key, this.title, this.group}) : super(key: key);
  final String title;
  final Group group;
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  createAlertDialog(BuildContext context, String text) {
    // exits out of the pop up
    Widget cancelButton = MaterialButton(
      elevation: 5.0,
      child: Text(
        'Okay, got it!',
        style: TextStyle(
          color: Color(0xff27b4c3),
        ),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
    // allows text to be entered
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentTextStyle: TextStyle(
            color: Color(0xff27b4c3),
          ),
          title: Text(text),
          actions: <Widget>[
            cancelButton,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // an App Bar for the top of the screen
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.group.name,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        // align at the top of the screen
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // spacing
          SizedBox(
            height: 40.0,
          ),
          // image for group profile picture
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('images/App Background2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Image.asset(
            'images/HangEz Logo.png',
            width: 150,
            height: 150,
          ),
          // place for group description
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: new Text(
              widget.group.groupID + "\n" + widget.group.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff27b4c3),
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
            ),
          ),
          // spacing
          SizedBox(height: 15.0),
          // chat button
          Container(
            child: RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed('/chat'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              // gradient design
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff27b4c3), Color(0xff84dfa0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Chat Channel",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
          // spacing
          SizedBox(height: 15.0),
          // poll channel button
          Container(
            child: RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed('/poll'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              // gradient design
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff27b4c3), Color(0xff84dfa0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Poll Channel",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
          // spacing
          SizedBox(height: 15.0),
          // view members button
          Container(
            child: RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed('/member'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              // gradient design
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff27b4c3), Color(0xff84dfa0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "View Members",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
          // spacing
          SizedBox(height: 15.0),
          // poll button
          Container(
            child: RaisedButton(
              onPressed: () =>
                  createAlertDialog(context, 'Successfully Created Poll'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              // gradient design
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff27b4c3), Color(0xff84dfa0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Create a Poll",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
