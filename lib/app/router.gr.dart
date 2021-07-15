
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:techno_cloud_task/ui/add_post_view.dart';
import 'package:techno_cloud_task/ui/home_view.dart';

class Routes {
  static const String HomeView = '/HomeView';
//  static const String AddPostView = '/AddPostView';

  static const all = <String>{
    HomeView,
  //  AddPostView,
  };

}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.HomeView, page: HomeView),
  //  RouteDef(Routes.AddPostView, page: AddPostView),
  ];

    @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    // AddPostView: (data) {
    //   return MaterialPageRoute<dynamic>(
    //     builder: (context) => AddPostView(),
    //     settings: data,
    //   );
    // },
  };
}