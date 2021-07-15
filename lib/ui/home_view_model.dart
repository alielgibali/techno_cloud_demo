import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:techno_cloud_task/app_services/firestoredbservice.dart';
import 'package:techno_cloud_task/models/test_model.dart';

class HomeViewModel extends BaseViewModel {
  bool isBusy = true;
  Stream<List<TestModel>> _postsStream;
  List<TestModel> _postsList = [];
  
  Stream<List<TestModel>> get postsStream => _postsStream;

  init() async {
    _postsStream = DBService().getAllPosts();

    isBusy = false;
    notifyListeners();
  }

  List<TestModel> get postsList => _postsList;
  
  currentPostsList(List<TestModel> list) {
    _postsList = list;
  //  notifyListeners();
  }

} 