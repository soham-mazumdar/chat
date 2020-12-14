import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService{
  
  Future<void> addDoc(msg) async{
    print('object');
    FirebaseAuth _auth = FirebaseAuth.instance;
    User currentUser =  _auth.currentUser; 
    
    CollectionReference medsRef = FirebaseFirestore.instance.collection("chats");
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    await medsRef.doc(id).set({
      'msg' : msg,
      'name': currentUser.displayName ?? currentUser.email,
      'uid' : currentUser.uid,
      'time': DateFormat("h:mm a").format(DateTime.now()),
    }); 
  }
}