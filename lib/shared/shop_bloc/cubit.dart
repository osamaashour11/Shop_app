import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/categories_model/categories_model.dart';
import 'package:flutter_shop_app/models/favorites_model/favorites_model.dart';
import 'package:flutter_shop_app/models/home_model/home_model.dart';
import 'package:flutter_shop_app/models/login_data_model/login_data_model.dart';
import 'package:flutter_shop_app/modules/home_screens/categories/categories.dart';
import 'package:flutter_shop_app/modules/home_screens/favorites/favorites.dart';
import 'package:flutter_shop_app/modules/home_screens/products/products.dart';
import 'package:flutter_shop_app/modules/home_screens/settings/settings.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/constants/constants.dart';
import 'package:flutter_shop_app/shared/constants/end_points.dart';
import 'package:flutter_shop_app/shared/network/remote/dio/dio_helper.dart';
import 'package:flutter_shop_app/shared/shop_bloc/states.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(InitializeShopAppState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  // variables
  int currentIndex = 0;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  FavoritesModel? favoritesModel;
  LoginShopAppDataModel? userDataModel;
  Map<int, bool> favorites = {};

  // lists
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.production_quantity_limits,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.category_outlined,
      ),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite_outline,
      ),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings_outlined,
      ),
      label: 'Settings',
    ),
  ];

  // functions
  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(ChangeBottomNavBarShopApp());
  }

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
    });
  }

  void getCategoriesData() {
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      emit(ShopErrorCategoriesDataState());
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopFavoritesDataState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      if (!favoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      defultFlutterToast(
        text: favoritesModel!.message!,
        toastStates: ToastStates.SUCCESS,
      );
      emit(ShopSuccessFavoritesDataState(favoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorCategoriesDataState());
    });
  }

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesDataState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error) {
      emit(ShopErrorFavoritesDataState());
    });
  }

  void getUserData() {
    emit(ShopLoadingGetProfileDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userDataModel = LoginShopAppDataModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateDataOfShopAppState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userDataModel = LoginShopAppDataModel.fromJson(value.data);
      emit(ShopUpdateSuccessDataOfShopAppState(userDataModel!));
    }).catchError((error) {
      emit(ShopUpdateErrorDataOfShopAppState(error));
    });
  }
}
