import 'dart:async';

import 'package:allerternatives/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final String uid;

  FirestoreService({this.uid});

  final CollectionReference userAllergensCollectionReference =
      Firestore.instance.collection("user_allergens");

  Future updateUserData(String allergen) async {
    if (allergen == null) {
      return await userAllergensCollectionReference.document(uid).setData({
        'allergens': [],
      });
    } else {
      return await userAllergensCollectionReference.document(uid).updateData({
        'allergens': FieldValue.arrayUnion([allergen]),
      });
    }
  }

  Future removeUserData(String allergen) async {
    try {
      return await userAllergensCollectionReference.document(uid).updateData({
        'allergens': FieldValue.arrayRemove([allergen]),
      });
    } catch (e) {
      print(e);
    }
  }

//  // userData from snapshot
//  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
//    return UserData(
//      uid: uid,
//      allergens: snapshot.data['allergens'],
//    );
//  }

  // get allergens stream
  Stream<UserData> get userData {
    return userAllergensCollectionReference.document(uid)
        .snapshots().map((document) => UserData.fromMap(document.data, uid));
  }

//  // get user doc stream
//  Stream<UserData> get userData {
//    return userAllergensCollectionReference
//        .document(uid)
//        .snapshots()
//        .map(_userDataFromSnapshot);
//  }
}
