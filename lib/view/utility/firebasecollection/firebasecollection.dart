import 'package:cloud_firestore/cloud_firestore.dart';

class firebasecollections{


  static final CollectionReference UserdataList =
    FirebaseFirestore.instance.collection('Users');

}