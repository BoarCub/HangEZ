import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/ObjectClasses/user.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // method to build a single message
  _buildMessage(String text, bool isNotMe) {
    return Container(
      margin: isNotMe
          ? EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: BoxDecoration(
          color: isNotMe ? Color(0xff89e7f1) : Colors.lightBlue,
          borderRadius: isNotMe
              ? BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                )),
      child: Text(text),
    );
  }

  // a method to display the controller to send a message
  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<bool> messages = [
      true,
      false,
      true,
      false,
      false,
      false,
      true,
      true,
      true,
      false,
      true,
      false,
      false,
      true,
      false,
      true,
      false,
      false
    ];
    List<String> messageStrings = [
      'Hey what movie should we choose guys?',
      'Hmm I do not know...',
      'Are you down to watch Frozen 2?',
      'Bro for sure!',
      'I love that movie so much.',
      'I kind of have a crush on Anna not gonna lie...',
      'No way, I have a crush on Elsa',
      'She is my role model in life',
      'I watch the movie just to see her',
      'You are soo wrong! Anna is way better',
      'Whatever bro',
      'I think we have to agree to disagree',
      'Even though I am right',
      'Whatever. Anyways, what time you free?',
      'I am free tomorrow at 5 PM',
      'Ok, me too!',
      'See you then',
      'I am so excited!'
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // display app bar at top of screen
      appBar: AppBar(
        title: Text(
          'Chat Channel',
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
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 15.0),
                itemCount: messages.length,
                // loop through amount of messages in the message list
                itemBuilder: (BuildContext context, int index) {
                  return _buildMessage(messageStrings[index], messages[index]);
                },
              ),
            ),
          ),
          // add the message controller
          _buildMessageComposer(),
        ],
      ),
    );
  }
}
