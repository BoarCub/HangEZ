import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HelperClasses/authenticate.dart';
import 'AppScreens/home_page.dart';
import 'AppScreens/login_page.dart';
import 'AppScreens/account.dart';
import 'ObjectClasses/user.dart';
import 'AppScreens/signup_page.dart';
import 'AppScreens/group_home.dart';
import 'AppScreens/poll_page.dart';
import 'AppScreens/faq_page.dart';
import 'AppScreens/member_view.dart';
import 'AppScreens/create_group.dart';
import 'HelperClasses/chat_page.dart';
import 'ObjectClasses/appInfo.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AuthService>(
      child: MyApp(),
      builder: (BuildContext context) {
        return AuthService();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  //final User user = null;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Virtual Hangout Scheduler',
        theme: ThemeData(
            primaryColor: Color(0xff27b4c3),
            appBarTheme: AppBarTheme(
                color: Color(0xff27b4c3))), //brightness: _brightness
        routes: <String, WidgetBuilder>{
          '/signup': (BuildContext context) => new SignUpPage(),
          '/home': (BuildContext context) => new HomePage(),
          '/account': (BuildContext context) => new AccountPage(),
          '/poll': (BuildContext context) => new PollPage(),
          '/faq': (BuildContext context) => new FAQPage(),
          '/chat': (BuildContext context) => new ChatPage(),
          '/group': (BuildContext context) => new GroupPage(),
          '/createGroup': (BuildContext context) => new CreateGroupPage(),
          '/member': (BuildContext context) => new MemberView(),
        },
        home: FutureBuilder(
          future: Provider.of<AuthService>(context).getUser(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginPage();
              //return snapshot.hasData ? HomePage() : LoginPage();
            }
            //return CircularProgressIndicator();
          },
        ));
  }
}
