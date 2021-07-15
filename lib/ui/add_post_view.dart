import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:techno_cloud_task/models/test_model.dart';
import 'package:techno_cloud_task/ui/widgets/appbar_widget.dart';
import 'package:techno_cloud_task/utilities/theme_const.dart';
import 'package:techno_cloud_task/utilities/common_const.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:path/path.dart' as p;

class AddPostView extends StatefulWidget {
  @override
  _AddPostViewState createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File _storedImage;
  bool _isLoading = false;
  final _titleFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  var _title = '';
  var _description = '';

  @override
  void dispose() {
    super.dispose();
    _titleFocus.dispose();
    _descriptionFocus.dispose();
  }

  Future<void> _takePicture() async {
    List<Media> _listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: Colors.blueAccent),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));

    if (_listImagePaths == null) {
      return;
    }
    setState(() {
      _storedImage = File(_listImagePaths[0].path);
      debugPrint('########  image is $_storedImage');
    });
  }

  void _trySubmit() async {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      _submitAuthForm();
    }
  }

  Future<String> uploadFile(String imagePath, String name) async {
    File file = File(imagePath);
    String fileName = '';
    if (name != null && name.length > 0) {
      fileName = name.substring(0, name.length - 4);
    }

    final ref = FirebaseStorage.instance
        .ref()
        .child('posts_images')
        .child(name.toLowerCase())
        .child(fileName);
    TaskSnapshot snapshot = await ref.putFile(file);
    return await snapshot.ref.getDownloadURL();
  }

  void _submitAuthForm() async {
    String result = '';

    if (this.mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    String baseName = p.basename(_storedImage.path);
    String filePath = _storedImage.path;
    String img = await uploadFile(filePath, baseName);
    print('### img is $img');
     String docId =
          FirebaseFirestore.instance.collection('posts').doc().id;
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('posts').doc(docId);
    TestModel model = new TestModel(
      docId: docId,
      title: _title,
      description: _description,
      imageUrl: img,
      isSelected: false,
    );
    await docRef.set(model.toJson());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        ScreensAppBar(title: "Add Post"),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: width * 0.8,
                        child: GestureDetector(
                          onTap: _takePicture,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: waterBlue,
                            child: _storedImage == null
                                ? Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )
                                : null,
                            backgroundImage: _storedImage != null
                                ? FileImage(_storedImage)
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.getHeight(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: width * 0.85,
                        child: TextFormField(
                          key: ValueKey('title'),
                          style: TextStyle(color: Colors.black),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.sentences,
                          enableSuggestions: false,
                          validator: (value) {
                            if (value.isEmpty || value.length < 3)
                              return 'Please enter at least 3 characters.';
                            return null;
                          },
                          focusNode: _titleFocus,
                          decoration: InputDecoration(
                            hintText: 'title',
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: 25.getFontSize()),
                            filled: true,
                            fillColor: whiteTwo,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                color: warmGrey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: warmGrey,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          controller: _titleController,
                          keyboardType: TextInputType.text,
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocus);
                          },
                          onSaved: (value) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocus);
                            _title = value.trim();
                          },
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: 20.getHeight(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: width * 0.85,
                        child: TextFormField(
                          key: ValueKey('description'),
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          style: TextStyle(color: Colors.black),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.sentences,
                          enableSuggestions: false,
                          validator: (value) {
                            if (value.isEmpty || value.length < 3)
                              return 'Please enter at least 3 characters.';
                            return null;
                          },
                          focusNode: _descriptionFocus,
                          decoration: InputDecoration(
                            hintText: 'description',
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: 25.getFontSize()),
                            filled: true,
                            fillColor: whiteTwo,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                color: warmGrey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: warmGrey,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          controller: _descriptionController,
                          //  keyboardType: TextInputType.text,
                          onEditingComplete: () {
                            // FocusScope.of(context)
                            //     .requestFocus(_descriptionFocus);
                          },
                          onSaved: (value) {
                            // FocusScope.of(context)
                            //     .requestFocus(_descriptionFocus);
                            _description = value.trim();
                          },
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: 30.getHeight(),
                      ),
                      _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              height: 50,
                              width: width * 0.8,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Color(0xff0fa2cf)),
                                ),
                                onPressed: _trySubmit,
                                color: Color(0xff0fa2cf),
                                textColor: Colors.white,
                                child: Text("Add ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Grandstander",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 30.getFontSize()),
                                    textAlign: TextAlign.left),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
