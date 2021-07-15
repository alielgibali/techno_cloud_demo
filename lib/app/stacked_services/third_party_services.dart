import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:techno_cloud_task/utilities/image_selector.dart';


@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
  // @lazySingleton
  // FirestoreService get firestoreService;
  // @lazySingleton
  // DynamicLinkService get deepLinkService;
  // @lazySingleton
  // CloudStorageService get cloudStorageService;
  // @lazySingleton
  // ImageSelector get imageSelector;
}