import 'package:flutter/material.dart';
import 'package:techno_cloud_task/utilities/theme_const.dart';

class ScreensAppBar extends StatefulWidget {
  final String title;
  const ScreensAppBar({Key key, this.title})
      : super(key: key);


  @override
  _ScreensAppBarState createState() => _ScreensAppBarState();
}

class _ScreensAppBarState extends State<ScreensAppBar> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Container(
      height:  screen.height * 0.15,
      margin: EdgeInsets.symmetric(horizontal:  screen.width * 0.1),
      decoration: BoxDecoration(
          color: ceruleanTwo,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // InkWell(
          //   onTap: () => Navigator.pop(context),
          //   child: Container(
          //     width: screen.width * 0.35,
          //     child: Icon(
          //       Icons.arrow_back_ios_outlined,
          //       color: white,
          //       size: 20,
          //     ),
          //   ),
          // ),
          Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(color: white, fontSize: 26), 
              ),
            ],
          ),
        ],
      )),
    );
  }
}
