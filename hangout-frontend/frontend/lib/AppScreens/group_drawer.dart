import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ObjectClasses/user.dart';
import '../ObjectClasses/group.dart';
import '../HelperClasses/group_label.dart';
import 'group_home.dart';
import '../ObjectClasses/appInfo.dart';

class GroupDrawer extends StatefulWidget {
  GroupDrawer({Key key, this.appInfo}) : super(key: key);
  final AppInfo appInfo;
  _GroupDrawerState createState() => _GroupDrawerState();
}

class _GroupDrawerState extends State<GroupDrawer> {
  Widget buildPage() {
    return FutureBuilder(
        future: getGroupData(widget.appInfo.username),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Container(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Retrieving Group Data...'),
                  CircularProgressIndicator()
                ],
              ),
            ));
          } else {
            var previous = snapshot.data;
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data);
                  var resp = snapshot.data[index];
                  Group prevGroups = new Group(
                      groupID: resp.groupID,
                      name: resp.name,
                      adminID: resp.adminID,
                      description: resp.description);
                  if (index == 0) {
                    return DrawerHeader(
                      child: Center(
                          child: Text(
                        "Groups",
                        textScaleFactor: 2.0,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                      decoration: BoxDecoration(
                        color: Color(0xff27b4c3),
                      ),
                    );
                  }
                  index -= 1;
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(_confirmSubmit(prevGroups));
                    },
                    title: Text(prevGroups.name),
                    subtitle: Text(prevGroups.groupID.toString() +
                        "\n   " +
                        prevGroups.description),
                    isThreeLine: true,
                  );
                });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(child: buildPage());
  }

  Route _confirmSubmit(Group group) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => GroupPage(
        group: group,
        appInfo: widget.appInfo,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
