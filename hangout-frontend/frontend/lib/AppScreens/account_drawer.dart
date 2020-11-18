import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountDrawer extends StatelessWidget {
  get iconSize => null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.

        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,

      children: <Widget>[
        DrawerHeader(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 42.0,
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Color(0xff27b4c3),
          ),
        ),
        ListTile(
          title: Text('Account'),
          onTap: () {
            Navigator.of(context).pushNamed('/account');
          },
        ),
        ListTile(
          title: Text('FAQ'),
          onTap: () {
            Navigator.of(context).pushNamed('/faq');
          },
        ),
        ListTile(
          title: Text('Logout'),
          onTap: () {
            //Provider.of<AuthService>(context).logout();
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }
}
