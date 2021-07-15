import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:techno_cloud_task/app/locator.dart';
import 'package:techno_cloud_task/models/test_model.dart';
import 'package:techno_cloud_task/ui/add_post_view.dart';
import 'package:techno_cloud_task/ui/home_view_model.dart';
import 'package:techno_cloud_task/ui/widgets/appbar_widget.dart';
import 'package:techno_cloud_task/ui/widgets/like_post_widget.dart';
import 'package:techno_cloud_task/utilities/common_const.dart';
// import 'package:techno_cloud_task/app/router.gr.dart' as router;


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    // addSomeValues();
  }

  Future<void> addSomeValues() async {
    for (int i = 0; i < 10; i++) {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('posts').doc();
      TestModel model = new TestModel(
        docId: docRef.toString(),
        title: '$i',
        description: 'this is description for $i',
        imageUrl: 'image $i',
        isSelected: false,
      );
      await docRef.set(model.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) {
        if (model.isBusy) {
          return Scaffold(
            body: Container(
              height: screen.height,
              width: screen.width,
              //  decoration: BoxDecoration(gradient: blueGradient),
              child: Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }

        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.blue,
          //  appBar: ScreensAppBar(title: "Posts"),
          body: Column(
            children: [
              ScreensAppBar(title: "Posts"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10,
                  ),
                  child: StreamBuilder<List<TestModel>>(
                    stream: model.postsStream,
                    builder: (context, postsSnapshot) {
                      if (postsSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          child: Center(
                              child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          )),
                        );
                      } else {
                        model.currentPostsList(postsSnapshot.data ?? []);
                        return model.postsList.length == 0
                            ? Center(
                                child: Container(
                                  width: screen.width * 0.8,
                                  height: screen.height * 0.42,
                                  child: Stack(children: [
                                    Container(
                                      width: screen.width * 0.8,
                                      height: screen.height * 0.35,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "let's add post here",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                height: 1.2),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: model.postsList.length,
                                itemBuilder: (context, index) {
                                  return postWidget(model.postsList[index]);
                                  //Container();
                                  // return DiscussionItem(
                                  //     model: model,
                                  //     comment: model.isSearchOn
                                  //         ? model.filteredCommentsList[index]
                                  //         : model.commentsList[index]);
                                },
                              );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
           //   _navigationService.navigateTo(router.Routes.AddPostView,);
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddPostView()));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
          ),
        );
      },
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => HomeViewModel(),
      // fireOnModelReadyOnce: true,
    );
  }

  Widget postWidget(TestModel model) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: null,
        child: Stack(children: [
          Container(
            height: 140.getHeight(),
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // ad image
                Container(
                  width: size.width * 0.32,
                  height: 140.getHeight(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: model.imageUrl,
                      placeholder: (context, url) => SizedBox(
                        height: 50,
                        width: 50,
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, color: Colors.grey),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        //    Spacer(),
                        /* add to center complete container*/
                        Text(
                          model.title,
                          //  '${getAdTitle(carAd: carAd)}',
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 0.9,
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Text(
                          model.description,
                          style: TextStyle(
                              color: Color(0xff1b1c1e),
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.left, maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 15,
            bottom: 10,
            child: LikePostWidget(
              post: model,
              currentDoc: model.docId ?? "",
              isLiked: model.isSelected ?? false,
            ),
          )
        ]),
      ),
    );
  }
}
