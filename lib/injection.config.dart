// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hanoi_foodtour/repositories/general_repo.dart' as _i12;
import 'package:hanoi_foodtour/repositories/remote/auth_repo.dart' as _i3;
import 'package:hanoi_foodtour/repositories/remote/comment_repo.dart' as _i4;
import 'package:hanoi_foodtour/repositories/remote/food_repo.dart' as _i5;
import 'package:hanoi_foodtour/repositories/remote/like_repo.dart' as _i6;
import 'package:hanoi_foodtour/repositories/remote/rating_repo.dart' as _i7;
import 'package:hanoi_foodtour/repositories/remote/restaurant_repo.dart' as _i8;
import 'package:hanoi_foodtour/repositories/remote/search_repo.dart' as _i9;
import 'package:hanoi_foodtour/repositories/remote/upload_repo.dart' as _i10;
import 'package:hanoi_foodtour/repositories/remote/user_repo.dart' as _i11;
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
    gh.singleton<_i4.CommentRepo>(_i4.CommentRepo());
    gh.singleton<_i5.FoodRepo>(_i5.FoodRepo());
    gh.singleton<_i6.LikeRepo>(_i6.LikeRepo());
    gh.singleton<_i7.RatingRepo>(_i7.RatingRepo());
    gh.singleton<_i8.RestaurantRepo>(_i8.RestaurantRepo());
    gh.singleton<_i9.SearchRepo>(_i9.SearchRepo());
    gh.singleton<_i10.UploadRepo>(_i10.UploadRepo());
    gh.singleton<_i11.UserRepo>(_i11.UserRepo());
    gh.singleton<_i12.GeneralRepo>(_i12.GeneralRepo(
      gh<_i3.AuthRepo>(),
      gh<_i11.UserRepo>(),
      gh<_i8.RestaurantRepo>(),
      gh<_i7.RatingRepo>(),
      gh<_i5.FoodRepo>(),
      gh<_i9.SearchRepo>(),
      gh<_i4.CommentRepo>(),
      gh<_i6.LikeRepo>(),
      gh<_i10.UploadRepo>(),
    ));
    return this;
  }
}
