import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier {
  final String uid;
  List<String> allergenz = [];

  UnmodifiableListView<String> get allergens => UnmodifiableListView(allergenz);

  int get totalLength => allergenz.length;

  UserData({this.uid, this.allergenz});

  factory UserData.fromMap(Map<String, dynamic> map, String uID) {
    var uid = uID;
    var allergensFromMap = map['allergens'];
    List<String> allergensList = allergensFromMap.cast<String>();
    return new UserData(
      uid: uid,
      allergenz: allergensList,
    );
  }

  factory UserData.fromSnapshot(DocumentSnapshot snapshot) {
    return UserData.fromMap(snapshot.data, snapshot.documentID);
  }

  void printUserData() {
    print('uidd: $uid');
    print('allergenz ${allergens.toString()}');
  }
}
