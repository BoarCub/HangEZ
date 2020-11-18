import 'package:cloud_firestore/cloud_firestore.dart';

/*
 * Object Name: DatabaseService()
 * 
 * Developer: Deepayan Sanyal
 * 
 * Description: This class contain post and get utility methods to use for interacting with the Firebase Backend.
 * 
 * Implementation:
 *  - Firestore is a NoSQL Database. Our database has two collections: "users" and "groups".
 *  - Each collection is made of documents with fields. Each document can also have a subcollection.
 *  - View Technical Specifications and the Database UML for more information.
 * 
 * Dependencies: Firebase must be correctly configured in Flutter
 * 
*/

class DatabaseService{

  //Used to get a snapshot of user documents that match the given username
  //Input: username<String>
  //Output: QuerySnapshot of documents where username = given value
  getUserByUsername(String username) async{
    return FirebaseFirestore.instance.collection("users").where("username", isEqualTo: username).get();
  }

  //Used to get a snapshot of user documents that match the given email
  //Input: email<String>
  //Output: QuerySnapshot of documents where email = given value
  getUserByEmail(String email) async{
    return FirebaseFirestore.instance.collection("users").where("email", isEqualTo: email).get();
  }

  //Used to get a snapshot of group documents that match the given groupcode
  //Input: code<String>
  //Output: QuerySnapshot of documents under group where groupcode = given value
  getGroupByCode(String code) async{
    return FirebaseFirestore.instance.collection("groups").where("groupcode", isEqualTo: code).get();
  }

  // ! Deprecated Method
  //Used to get snapshot of group documents that the user is associated with
  //Input: username<String>, groupcode<String>
  //Output: QuerySnapshot of documents under user where groupcode = given value
  checkGroupOfUser(String username, String groupcode) async {
    
    FirebaseFirestore.instance.collection("users").where("username", isEqualTo: username).get().then((value){
      QuerySnapshot snapshot = value;
      String documentId = snapshot.docs[0].id;

      DocumentReference userDocument = FirebaseFirestore.instance.collection("users").doc(documentId);

      return userDocument.collection("groups").where("groupcode", isEqualTo: groupcode).get();

    });
  }

  //Used to get a snapshot with a single group document which matches the given groupcode and user document id
  //Input: id<String>, groupcode<String> --> Note: id refers to the internal document id associated with a user, not username
  //Output: QuerySnapshot of group document under the user document with the given id, where groupcode = given value
  checkGroupOfUserById(String id, String groupcode) async{
    return FirebaseFirestore.instance.collection("users").doc(id).collection("groups").where("groupcode", isEqualTo: groupcode).get();
  }

  //Used to get a snapshot with all the group documents under the given document id
  //Input: id<String> --> Note: id refers to the internal document id associated with a user, not username
  //Output: QuerySnapshot of the group documents under the user document with the given id
  getGroupsOfUserById(String id) async{
    return await FirebaseFirestore.instance.collection("users").doc(id).collection("groups").get();
  }

  //Used to post a new group during group creation
  //Input: creator<String> (this is the user that will become the admin), groupcode<String>, name<String>, description<String>
  //Result: Creates a new group under the "groups" collection in the database that users will be able to join
  postGroupToGroupCollection(String creator, String groupcode, String name, String description) async{
    Map<String, String> groupMap = {"admin": creator, "groupcode": groupcode, "name": name, "description": description};
    Map<String, String> membersMap = {"username": creator};

    CollectionReference collectionReference = FirebaseFirestore.instance.collection("groups");

    collectionReference.add(groupMap).then((documentReference){
      documentReference.collection("members").add(membersMap);
    });
  }

  //Used to post a group to the give user during group joining
  //Input: username<String, groupcode<String>
  //Result: Adds the given groupcode as a new document in the "groups" collection specific to the given user
  postGroupToUser(String username, String groupcode) async{
    
    Map<String, String> groupMap = {"groupcode": groupcode};
    
    FirebaseFirestore.instance.collection("users").where("username", isEqualTo: username).get().then((value){
      QuerySnapshot snapshot = value;
      String documentId = snapshot.docs[0].id;

      DocumentReference userDocument = FirebaseFirestore.instance.collection("users").doc(documentId);

      userDocument.collection("groups").add(groupMap);

    });
  }

  //Posts a new user to the "users" collection during registration
  //Inputs: username<String>, email<String> <-- Must be in Map<String, String> form
  //Result: new document created in the "users" collection representing the given user
  postUserDetails(map){
    FirebaseFirestore.instance.collection("users").add(map);
  }

  //Used to get a snapshot of the poll in the given groupcode with the given creationOrder
  //Input: groupcode<String>, pollCreationOrder<Integer>(represents the order the polls was created, with the first poll being 0)
  //Output: QuerySnapshot of the group documents under the user document with the given id
  getPollAsSnapshot(String groupcode, int pollCreationOrder) async {

    FirebaseFirestore.instance.collection("groups").where("groupcode", isEqualTo: groupcode).get().then((value){

      QuerySnapshot groupSnapshot;
      groupSnapshot = value;

      String groupDocId = groupSnapshot.docs[0].id;

      DocumentReference groupDoc = FirebaseFirestore.instance.collection("groups").doc(groupDocId);

      return groupDoc.collection("polls").where("creationOrder", isEqualTo: pollCreationOrder).get();

    });

  }

  //Used to post a new poll to the group during poll creation
  //Input: groupcode<String>, question<String>, answersText<List<String>> (this is a list of the text associated with an answer),
  //  isActive<Boolean> (whether the polls is active for voting at creation time), creationOrder<Integer> (the order in which the poll was created)
  //Result: Adds poll with the given attributes as a document under the "polls" collection for that group
  postPollToGroup(String groupcode, String question, List<String> answersText, bool isActive, int creationOrder) async{
    
    Map<String, dynamic> pollsMap = {"question": question, "isActive": isActive, "creationOrder": creationOrder};

    FirebaseFirestore.instance.collection("groups").where("groupcode", isEqualTo: groupcode).get().then((value){

      String documentId = value.docs[0].id;

      DocumentReference docReference = FirebaseFirestore.instance.collection("groups").doc(documentId);

      docReference.collection("polls").add(pollsMap).then((pollsReference){
        int index = 0;
        answersText.forEach((element) {
          Map<String, dynamic> answerMap = {"creationOrder": index, "text": element};
          pollsReference.collection("answers").add(answerMap);
          index++;
        });

      });

    });

  }

  //Used to update a user's answer to a poll during voting
  //Input: groupcode<String>, username<String>, pollCreationOrder<Integer>, answerNumber<Integer> (the number of the answer that the user will vote for, starting at 0)
  //Result: Updates or adds a vote document to the "votes" collection associated with that user in the poll document
  updateAnswerInPoll(String groupcode, String username, int pollCreationOrder, int answerNumber) async{

    Map<String, dynamic> voteMap = {"username": username, "vote": answerNumber};

    FirebaseFirestore.instance.collection("groups").where("groupcode", isEqualTo: groupcode).get().then((groupQuery){

      String groupDocId;
      groupDocId = groupQuery.docs[0].id;

      DocumentReference groupDocReference;
      groupDocReference = FirebaseFirestore.instance.collection("groups").doc(groupDocId);

      groupDocReference.collection("polls").where("creationOrder", isEqualTo: pollCreationOrder).get().then((pollsQuery){
        
        String pollDocId;
        pollDocId = pollsQuery.docs[0].id;

        DocumentReference pollDocReference;
        pollDocReference = FirebaseFirestore.instance.collection("groups").doc(groupDocId).collection("polls").doc(pollDocId);

        pollDocReference.collection("votes").where("username", isEqualTo: username).get().then((votesQuery){

          QuerySnapshot votesSnapshot;
          votesSnapshot = votesQuery;

          bool userVoted = votesQuery != null ? votesSnapshot.docs.length > 0 : false;

          if(userVoted){
            String voteId = votesSnapshot.docs[0].id;
            pollDocReference.collection("votes").doc(voteId).set(voteMap);
          } else{
            pollDocReference.collection("votes").add(voteMap);
          }

        });

      });

    });

  }

}