// This class creates a message object
import 'user.dart';

class Message {
  User user;
  String time;
  String date;
  String content;

  // Message class constructor
  Message({this.user, this.time, this.date, this.content});
}
