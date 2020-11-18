import 'dart:convert';
import '../ObjectClasses/group.dart';
import '../HelperClasses/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
 * Class Name: group_label
 * 
 * Developer: Deepayan Sanyal
 * 
 * Description: This class contains methods to get the groups a given user is associated with
 * 
 * Implementation:
 *  - Firestore is a NoSQL Database. Our database has two collections: "users" and "groups".
 *  - Each collection is made of documents with fields. Each document can also have a subcollection.
 *  - View Technical Specifications and the Database UML for more information.
 * 
 * Dependencies: Firebase must be correctly configured in Flutter
 * Dependencies: DatabaseService()
 * Dependencies: Group()
 * 
*/

//Internal method used to get the groups that the user is a part of
//Input: userId<String> (nothing special, just the username of the user)
//Output: List<Group> (a list of groups that the user is a part of in the form of Group objects)
Future getGroupHelper(String userid) async {
  
  DatabaseService databaseService = new DatabaseService();

  bool isFinished = false;
  List<Group> groups = new List<Group>();

  databaseService.getUserByUsername(userid).then((userDoc){
    QuerySnapshot userSnapshot;
    userSnapshot = userDoc;

    print(userid);

    String userDocId = userSnapshot.docs[0].id;

    databaseService.getGroupsOfUserById(userDocId).then((val2){

      QuerySnapshot groupsSnapshot;
      groupsSnapshot = val2;

      List<String> codes = new List<String>();

      groupsSnapshot.docs.forEach((element) {
        codes.add(element.data()["groupcode"]);
      });

      int index = 0;

      codes.forEach((element) {
        
        databaseService.getGroupByCode(element).then((groupDocs){

          QuerySnapshot groupSnapshot;
          groupSnapshot = groupDocs;

          Map<String, dynamic> groupData = groupSnapshot.docs[0].data();

          Group group = new Group();
          group.adminID = groupData["admin"];
          group.description = groupData["description"];
          group.groupID = groupData["groupcode"];
          group.name = groupData["name"];

          groups.add(group);

          index++;

          if(index >= codes.length){
            isFinished = true;
          }

        });

      });

    });

  });

  while(!isFinished){
    await Future.delayed(Duration(microseconds: 100));
  }

  print("Groups finished");
  return groups;

}

//External method used from other classes to get the groups that the user is a part of
//Input: userId<String> (nothing special, just the username of the user)
//Output: List<Group> (a list of groups that the user is a part of in the form of Group objects)
Future getGroupData(String userid) async {
  
  List<Group> groups = await getGroupHelper(userid);
  //print(groups.length);
  return groups;

}

// ! Deprecated
Future<String> joinGroup(String userid, int groupCode) async {
  print("User joining group");
  Map<String, dynamic> map = {
    'id': userid,
    'groupID': groupCode,
  };
  /*return await httpr.putUserInGroup(map).then((value) {
    return value.body;
  });*/
}
