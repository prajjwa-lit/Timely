

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class Firestore
{
  FirebaseFirestore db = FirebaseFirestore.instance;

  uploadTask(List<Map<String,dynamic>> ls,UserModel userModel) async
  {
    var data = await db.collection('user').doc(userModel.uid).get();
    if(data.exists) {
      await db
          .collection('user')
          .doc(userModel.uid)
          .update({'Tasks': FieldValue.arrayUnion(ls)});
    }
    else{
      await db
          .collection('user')
          .doc(userModel.uid)
          .set({'Tasks': FieldValue.arrayUnion(ls)});
    }
    log('ho gya');
  }

  removeTask(List<Map<String,dynamic>> ls,UserModel userModel)async{
    await db.collection('user').doc(userModel.uid).update({'Tasks' : FieldValue.arrayRemove(ls)});
    log('ho gya');
  }

  updateDoneStatus(List ls,UserModel user)async {
    await db.collection('user').doc(user.uid).update({'Tasks': ls});
    log('updated');
  }

  fetchUserData(UserModel userModel) async {

  }
  
}