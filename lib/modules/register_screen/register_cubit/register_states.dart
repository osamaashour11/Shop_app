import 'package:flutter_shop_app/models/login_data_model/login_data_model.dart';

abstract class RegisterShopAppStates {}

class RegisterInitializeShopAppState extends RegisterShopAppStates {}

class RegisterLoadingDataOfShopAppState extends RegisterShopAppStates {}

class RegisterGetSuccessDataOfShopAppState extends RegisterShopAppStates {
  final LoginShopAppDataModel loginShopAppDataModel;

  RegisterGetSuccessDataOfShopAppState(this.loginShopAppDataModel);
}

class RegisterGetErrorDataOfShopAppState extends RegisterShopAppStates {
  final String error;
  RegisterGetErrorDataOfShopAppState(this.error);
}

class RegisterChangePasswordVisibilityShopAppState
    extends RegisterShopAppStates {}
