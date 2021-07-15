import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techno_cloud_task/models/test_model.dart';
import 'package:techno_cloud_task/utilities/theme_const.dart';
import 'package:techno_cloud_task/utilities/common_const.dart';

class LikePostWidget extends StatefulWidget {
  final TestModel post;
  final String currentDoc;
  final bool isLiked;
  LikePostWidget({ this.post, this.currentDoc,  this.isLiked});

  @override
  _LikePostWidgetState createState() => _LikePostWidgetState();
}

class _LikePostWidgetState extends State<LikePostWidget> {

  Future<void> changeIsSelectedStatus(bool status) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('posts').doc(widget.currentDoc);
    Map<String, dynamic> data = {
      'isSelected': status,
    };
    return docRef.update(data);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        changeIsSelectedStatus(!widget.isLiked);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Icon(
          widget.isLiked ? Icons.favorite : Icons.favorite_border,
          size: 26.getFontSize(),
          color: carnationPink,
        ),
      ),
    );
  }
}
