import 'package:flutter_shop_app/models/favorites_model/favorites_model.dart';
import 'package:flutter_shop_app/models/login_data_model/login_data_model.dart';

abstract class ShopAppStates {}

class InitializeShopAppState extends ShopAppStates {}

class ChangeBottomNavBarShopApp extends ShopAppStates {}

class ShopLoadingHomeDataState extends ShopAppStates {}

class ShopSuccessHomeDataState extends ShopAppStates {}

class ShopErrorHomeDataState extends ShopAppStates {}

class ShopSuccessCategoriesDataState extends ShopAppStates {}

class ShopErrorCategoriesDataState extends ShopAppStates {}

class ShopFavoritesDataState extends ShopAppStates {}

class ShopSuccessFavoritesDataState extends ShopAppStates {
  final FavoritesModel favoritesModel;

  ShopSuccessFavoritesDataState(this.favoritesModel);
}

class ShopErrorFavoritesDataState extends ShopAppStates {}

class ShopLoadingGetFavoritesDataState extends ShopAppStates {}

class ShopSuccessGetFavoritesDataState extends ShopAppStates {}

class ShopErrorGetFavoritesDataState extends ShopAppStates {}

class ShopLoadingGetProfileDataState extends ShopAppStates {}

class ShopSuccessGetUserDataState extends ShopAppStates {}

class ShopErrorGetUserDataState extends ShopAppStates {}

class ShopUpdateDataOfShopAppState extends ShopAppStates {}

class ShopUpdateSuccessDataOfShopAppState extends ShopAppStates {
  final LoginShopAppDataModel loginShopAppDataModel;

  ShopUpdateSuccessDataOfShopAppState(this.loginShopAppDataModel);
}

class ShopUpdateErrorDataOfShopAppState extends ShopAppStates {
  final String error;
  ShopUpdateErrorDataOfShopAppState(this.error);
}
