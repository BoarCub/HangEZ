import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ObjectClasses/user.dart';
import '../ObjectClasses/group.dart';

class MemberView extends StatefulWidget {
  MemberView({Key key, this.users, this.group}) : super(key: key);

  final List<User> users;
  final Group group;

  _MemberViewState createState() => _MemberViewState();
}

class _MemberViewState extends State<MemberView> {
  List<String> members = [
    'Bubba (Admin)',
    'Parker (Admin)',
    'Ella (Member)',
    'Viraj (Member)',
    'Mikey (Member)',
    'Deep (Member)',
    'Adam (Member)',
    'Bob (Member)',
    'Romeo (Member)',
    'Juliet (Member)',
  ];
  // method to display one member
  _buildMember(String typeUser) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 20.0, left: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
          color: Color(0xff89e7f1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
          )),
      child: new Text(
        typeUser,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff131313),
            fontSize: 25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // an app bar at top of screen
      appBar: AppBar(
        title: Text(
          'Member View',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              // build a list of members
              child: ListView.builder(
                padding: EdgeInsets.only(top: 15.0),
                itemCount: members.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildMember(members[index]);
                  /*// conditional to check if user is an admin or member
                  if (widget.group.adminID == widget.users[index].id) {
                    return _buildMember(widget.users[index], 'admin');
                  } else {
                    return _buildMember(widget.users[index], 'member');
                  }*/
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
