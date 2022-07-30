import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/login_data_model/login_data_model.dart';
import 'package:flutter_shop_app/modules/login_screen/login_cubit/login_states.dart';
import 'package:flutter_shop_app/modules/register_screen/register_cubit/register_states.dart';
import 'package:flutter_shop_app/shared/constants/end_points.dart';
import 'package:flutter_shop_app/shared/network/remote/dio/dio_helper.dart';

class RegisterShopAppCubit extends Cubit<RegisterShopAppStates> {
  RegisterShopAppCubit() : super(RegisterInitializeShopAppState());

  static RegisterShopAppCubit get(context) => BlocProvider.of(context);

  LoginShopAppDataModel? loginShopAppDataModel;
  bool passwordVisible = true;
  IconData iconData = Icons.remove_red_eye;

  void changePasswordVisibility() {
    passwordVisible = !passwordVisible;
    iconData = passwordVisible ? Icons.remove_red_eye : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityShopAppState());
  }

  void userData({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingDataOfShopAppState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      loginShopAppDataModel = LoginShopAppDataModel.fromJson(value.data);
      emit(RegisterGetSuccessDataOfShopAppState(loginShopAppDataModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterGetErrorDataOfShopAppState(error));
    });
  }
}
