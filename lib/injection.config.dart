// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hanoi_foodtour/repositories/general_repo.dart' as _i6;
import 'package:hanoi_foodtour/repositories/remote/auth_repo.dart' as _i3;
import 'package:hanoi_foodtour/repositories/remote/restaurant_repo.dart' as _i4;
import 'package:hanoi_foodtour/repositories/remote/user_repo.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AuthRepo>(_i3.AuthRepo());
    gh.singleton<_i4.RestaurantRepo>(_i4.RestaurantRepo());
    gh.singleton<_i5.UserRepo>(_i5.UserRepo());
    gh.singleton<_i6.GeneralRepo>(_i6.GeneralRepo(
      gh<_i3.AuthRepo>(),
      gh<_i5.UserRepo>(),
      gh<_i4.RestaurantRepo>(),
    ));
    return this;
  }
}
