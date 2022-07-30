import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/login_data_model/login_data_model.dart';
import 'package:flutter_shop_app/modules/login_screen/login_cubit/login_states.dart';
import 'package:flutter_shop_app/shared/constants/end_points.dart';
import 'package:flutter_shop_app/shared/network/remote/dio/dio_helper.dart';

class LoginShopAppCubit extends Cubit<LoginShopAppStates> {
  LoginShopAppCubit() : super(LoginInitializeShopAppState());

  static LoginShopAppCubit get(context) => BlocProvider.of(context);

  LoginShopAppDataModel? loginShopAppDataModel;
  bool passwordVisible = true;
  IconData iconData = Icons.remove_red_eye;

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    iconData = passwordVisible ? Icons.remove_red_eye : Icons.visibility_off;
    emit(LoginChangePasswordVisibilityShopAppState());
  }

  void userData({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingDataOfShopAppState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginShopAppDataModel = LoginShopAppDataModel.fromJson(value.data);
      emit(LoginGetSuccessDataOfShopAppState(loginShopAppDataModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginGetErrorDataOfShopAppState(error));
    });
  }
}
