
import 'package:auto_route/annotations.dart';
import 'package:techno_cloud_task/ui/add_post_view.dart';
import 'package:techno_cloud_task/ui/home_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: HomeView, name: 'HomeView'),
   // AutoRoute(page: AddPostView, name: 'AddPostView'),
  ],
)
class $Router {}
