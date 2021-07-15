// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i5;

import '../utilities/image_selector.dart' as _i8;
import 'stacked_services/third_party_services.dart' as _i9; // ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get, {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  return get;
}

class _$ThirdPartyServicesModule extends _i9.ThirdPartyServicesModule {
  @override
  _i5.DialogService get dialogService => _i5.DialogService();

  // @override
  // _i8.ImageSelector get imageSelector => _i8.ImageSelector();

  @override
  _i5.NavigationService get navigationService => _i5.NavigationService();
}
