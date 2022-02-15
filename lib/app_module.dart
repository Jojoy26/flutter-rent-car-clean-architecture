import 'package:connectivity/connectivity.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rent/core/domain/repository/get_repository.dart';
import 'package:flutter_rent/core/domain/usecases/get_brands.dart';
import 'package:flutter_rent/core/domain/usecases/get_car_by_ref.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars_by_brand.dart';
import 'package:flutter_rent/core/domain/usecases/get_cars_by_search.dart';
import 'package:flutter_rent/core/domain/usecases/get_current_user.dart';
import 'package:flutter_rent/core/domain/usecases/get_favorites.dart';
import 'package:flutter_rent/core/domain/usecases/get_user_rent_cars.dart';
import 'package:flutter_rent/core/domain/usecases/rent_car.dart';
import 'package:flutter_rent/core/domain/usecases/save_favorites.dart';
import 'package:flutter_rent/core/domain/usecases/singin_by_google.dart';
import 'package:flutter_rent/core/external/firebaseRentCar/firebase_rent_car_datasource_impl.dart';
import 'package:flutter_rent/core/infra/datasources/get_datasource.dart';
import 'package:flutter_rent/core/infra/repositories/get_repository_impl.dart';
import 'package:flutter_rent/core/infra/repositories/favorites_repository_impl.dart';
import 'package:flutter_rent/core/infra/repositories/rent_car_repository_impl.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_rent_car_presenter.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_rents_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'commons/networkInfo/network_info.dart';
import 'core/domain/repository/favorites_repository.dart';
import 'core/domain/repository/rent_car_repository.dart';
import 'core/domain/repository/user_repository.dart';
import 'core/domain/usecases/login_by_email.dart';
import 'core/domain/usecases/singup_by_email.dart';

import 'core/external/firebaseGet/firebase_get_datasource.dart';
import 'core/external/firebaseuser/firebase_user_datasource_impl.dart';
import 'core/external/localFavorites/local_favorites_datasource_impl.dart';
import 'core/infra/datasources/favorites_datasource.dart';
import 'core/infra/datasources/rent_car_datasource.dart';
import 'core/infra/datasources/user_datasource.dart';
import 'core/infra/repositories/user_repository_impl.dart';
import 'core/presentation/presenters/getx_car_details_presenter.dart';
import 'core/presentation/presenters/getx_categories_presenter.dart';
import 'core/presentation/presenters/getx_checkout_presenter.dart';
import 'core/presentation/presenters/getx_favorites_presenter.dart';
import 'core/presentation/presenters/getx_login_presenter.dart';
import 'core/presentation/presenters/getx_pick_rent_date_presenter.dart';
import 'core/presentation/presenters/getx_saved_presenter.dart';
import 'core/presentation/presenters/getx_singup_presenter.dart';
import 'core/presentation/presenters/getx_splash_presenter.dart';
import 'core/presentation/presenters/getx_user_presenter.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.factory((i) => Connectivity()),
    Bind.factory<NetworkInfo>((i) => NetworkInfoImpl(connectivity: i())),
    

    Bind.factory<LoginByEmail>((i) => LoginByEmailImpl(repository: i())),
    Bind.factory<SingUpByEmail>((i) => SingUpByEmailImpl(repository: i())),
    Bind.factory<SingInByGoogle>((i) => SingInByGoogleImpl(repository: i())),
    Bind.factory<GetCurrentUser>((i) => GetCurrentUserImpl(repository: i())),

    Bind.factory<GetBrands>((i) => GetBrandsImpl(repository: i())),
    Bind.factory<GetCars>((i) => GetCarsImpl(repository: i())),
    Bind.factory<GetCarsByBrand>((i) => GetCarsByBrandImpl(repository: i())),
    Bind.factory<GetCarsBySearch>((i) => GetCarsBySearchImpl(repository: i())),
    Bind.factory<RentCar>((i) => RentCarImpl(repository: i())),
    Bind.factory<GetCarByRef>((i) => GetCarByRefImpl(repository: i())),
    Bind.factory<GetUserRentCars>((i) => GetUserRentCarsImpl(repository: i())),

    Bind.factory<GetFavorites>((i) => GetFavoritesImpl(repository: i())),
    Bind.factory<SaveFavorites>((i) => SaveFavoritesImpl(repository: i())),

    Bind.factory<UserDatasource>((i) => FirebaseUserDatasourceImpl()),
    Bind.factory<GetDatasource>((i) => FirebaseGetDatasourceImpl()),
    Bind.factory<FavoritesDatasource>((i) => LocalFavoritesDatasourceImpl()),
    Bind.factory<RentCarDatasource>((i) => FirebaseRentCarDatasourceImpl()),

    Bind.factory<UserRepository>((i) => UserRepositoryImpl(datasource: i(), netInfo: i())),
    Bind.factory<GetRepository>((i) => GetRepositoryImpl(datasource: i(), netInfo: i())),
    Bind.factory<FavoritesRepository>((i) => FavoritesRepositoryImpl(datasource: i())),
    Bind.factory<RentCarRepository>((i) => RentCarRepositoryImpl(datasource: i(), netInfo: i())),
    
    Bind.factory((i) => GetxSavedPresenter(favoritesPresenter: i(), getCarByRefUsecase: i(), rentCarPresenter: i())),
    Bind.factory<GetxRentsPresenter>((i) => GetxRentsPresenter(getCarByRefUsecase: i(), getUserRentCarsUsecase: i(), userPresenter: i(), rentCarPresenter: i())),
    Bind.factory<GextCheckoutPresenter>((i) => GextCheckoutPresenter(rentCarPresenter: i())),
    Bind.factory<GetxPickRentDatePresenter>((i) => GetxPickRentDatePresenter(rentCarPresenter: i())),
    Bind.singleton<GetxRentCarPresenter>((i) => GetxRentCarPresenter(rentCarUsecase: i(), userPresenter: i())),
    Bind.factory<GetxCarDetailsPresenter>((i) => GetxCarDetailsPresenter(rentCarPresenter: i())),
    Bind.singleton<GetxFavoritesPresenter>((i) => GetxFavoritesPresenter(getFavoritesUsecase: i(), saveFavoritesUsecase: i())),
    Bind.factory<GetxSplashPresenter>((i) => GetxSplashPresenter(getCurrentUserUsecase: i(), userPresenter: i())),
    Bind.factory<GetxCategoriesPresenter>((i) => GetxCategoriesPresenter(getBrandsUsecase: i(), getCarsUsecase: i(), getCarsByBrandUsecase: i(), getCarsBySearchUsecase: i(), favoritesPresenter: i())),
    Bind.singleton<GetxUserPresenter>((i) => GetxUserPresenter(loginByEmailUsecase: i(), singInByGoogleUsecase: i(), singUpByEmailUsecase: i())),
    Bind.factory<GetxSingUpPresenter>((i) => GetxSingUpPresenter(userPresenter: i())),
    Bind.factory<GetxLoginPresenter>((i) => GetxLoginPresenter(userPresenter: i()))
  ];
}