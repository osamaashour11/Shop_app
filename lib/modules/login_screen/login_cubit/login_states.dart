import 'package:flutter_shop_app/models/login_data_model/login_data_model.dart';

abstract class LoginShopAppStates {}

class LoginInitializeShopAppState extends LoginShopAppStates {}

class LoginLoadingDataOfShopAppState extends LoginShopAppStates {}

class LoginGetSuccessDataOfShopAppState extends LoginShopAppStates {
  final LoginShopAppDataModel loginShopAppDataModel;

  LoginGetSuccessDataOfShopAppState(this.loginShopAppDataModel);
}

class LoginGetErrorDataOfShopAppState extends LoginShopAppStates {
  final String error;
  LoginGetErrorDataOfShopAppState(this.error);
}

class LoginChangePasswordVisibilityShopAppState extends LoginShopAppStates {}
