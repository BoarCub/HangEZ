import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  FAQPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // create App Bar for the top of the screen with a title
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Frequently Asked Questions",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      // create List View to be able to scroll through the questions if needed
      body: ListView(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              // align questions at the top center of the screen
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // spacing
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'What language are you coding your app in?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xff27b4c3),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'We are using python and dart (in conjunction with the Flutter mobile UI framework) to write the code for our app.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                // spacing
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'What are you using to build the UI?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xff27b4c3),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'We are using the Flutter mobile app framework to develop the UI.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                // spacing
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'Which movies are supported by your app?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xff27b4c3),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: new Text(
                    'A lot of movies and genres that are supported by Netflix are also supported by our app.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                // spacing
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'Which platforms is your app compatible with?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xff27b4c3),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'iOS and Android.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'How many people can a single group allow?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xff27b4c3),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'There can be up to fifty people added to one group.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                // spacing
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'How do you ensure user security/privacy?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xff27b4c3),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                    child: new Text(
                      'User security/privacy will be ensured using SSL security protocols.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    )),
                // spacing
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'When is the estimated release date of the app?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xff27b4c3),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'The estimated release date is November 12th.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                // spacing
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'How will group invites be sent to other users?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xff27b4c3),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  child: new Text(
                    'Invites will be sent through the app itself and show up as a notification in a user’s message box.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
