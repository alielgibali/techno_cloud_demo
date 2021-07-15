
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techno_cloud_task/models/test_model.dart';

class DBService {
  var _fbd = FirebaseFirestore.instance;
  var _fireAuth = FirebaseAuth.instance;

  CollectionReference postsCollectionReference = FirebaseFirestore.instance.collection('posts');

  Stream<List<TestModel>> getAllPosts() {
    return _fbd
        .collection('posts')
        .snapshots()
        .map((qSnap) => qSnap.docs.map((doc) => TestModel.fromJson(doc.data(),)).toList());
  }
}