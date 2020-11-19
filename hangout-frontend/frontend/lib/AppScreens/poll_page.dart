import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../HelperClasses/database.dart';
import 'dart:async';
import '../ObjectClasses/group.dart';
import '../ObjectClasses/appInfo.dart';

import 'dart:io';

class TextStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/../assets/NetflixAPIGenres.txt');
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }
}

class PollPage extends StatefulWidget {
  PollPage({Key key, this.title, this.group, this.appInfo}) : super(key: key);
  final String title;
  final Group group;
  final AppInfo appInfo;
  final TextStorage storage = TextStorage();
  @override
  _PollPageState createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  String _content = '';
  List<String> questions = [
    'Action and Adventure',
    'Anime',
    'Children',
    'Comedies',
    'Documentaries',
    'Drama and Romance',
    'Horrors and Thrillers',
    'Science Fiction',
  ];
  DatabaseService databaseService = new DatabaseService();
  List<int> votes = new List.filled(8, 0);
  
  Timer timer;
  
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(microseconds: 50), (Timer t) => updateResponses());
    widget.storage.readFile().then((String text) {
      setState(() {
        _content = text;
      });
    });
  }

void updateResponses(){
  databaseService.getPollResults(widget.group.groupID, 0, questions.length).then((value){
            List<int> results = value;
            setState(() {
              votes = results;
            });
  });
}

  // method to build a singular poll option
  _buildOption(String text) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0, left: 20.0),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
      width: 500,
      height: 50,
      // create a button for the options
      child: RaisedButton(
        //Poll Button
        onPressed: () {
          print(text);
          int num = 0;
          int counter = 0;
          questions.forEach((element) {
            if(text == element){
              num = counter;
            }
            counter++;
          });

          databaseService.updateAnswerInPoll(widget.group.groupID, widget.appInfo.username, 0, num);

          /*databaseService.getPollResults("BRUH42", 0, questions.length).then((value){
            List<int> results = value;
            setState(() {
              votes = results;
            });
          });*/

        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        // gradient decoration
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff27b4c3), Color(0xff84dfa0)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 3000.0, minHeight: 50.0),
            alignment: Alignment.center,
            // display the option text based on input
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }

  _buildVotesDisplay(String text) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0, left: 20.0),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
      width: 500,
      height: 50,
      // create a button for the options
      child: RaisedButton(
        //Poll Button
        onPressed: () {
          
          print("yo");

        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: EdgeInsets.all(0.0),
        // gradient decoration
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff27b4c3), Color(0xff84dfa0)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 3000.0, minHeight: 50.0),
            alignment: Alignment.center,
            // display the option text based on input
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }

  // build a complete poll
  _buildPoll() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 10.0, left: 10.0),
          child: Text(
            'What genre do you want to see?',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff27b4c3),
                backgroundColor: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
        ),
        // loops through options to display all of them dynamically
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 6.0),
              itemCount: questions.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildOption(questions[index]);
              },
            ),
          ),
        ),

        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 6.0),
              itemCount: questions.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildVotesDisplay(votes[index].toString());
              },
            ),
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Poll Channel',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: _buildPoll(),
    );
  }
}
