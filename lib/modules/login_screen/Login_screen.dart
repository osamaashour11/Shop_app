import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/shop_layout/shop_layout.dart';
import 'package:flutter_shop_app/modules/login_screen/login_cubit/login_cubit.dart';
import 'package:flutter_shop_app/modules/login_screen/login_cubit/login_states.dart';
import 'package:flutter_shop_app/modules/register_screen/register_screen.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/constants/constants.dart';
import 'package:flutter_shop_app/shared/network/local/shared_preferences/cache_helper.dart';
import 'package:flutter_shop_app/shared/shop_bloc/cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginShopAppCubit(),
      child: BlocConsumer<LoginShopAppCubit, LoginShopAppStates>(
        listener: (context, state) {
          if (state is LoginGetSuccessDataOfShopAppState) {
            if (state.loginShopAppDataModel.status == true) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginShopAppDataModel.data!.token,
              ).then((value) {
                token = state.loginShopAppDataModel.data!.token;
                navigateAndFinish(context, const ShopLayout());
                defultFlutterToast(
                  text: '${state.loginShopAppDataModel.message}',
                  toastStates: ToastStates.SUCCESS,
                );
              });
            } else {
              defultFlutterToast(
                text: '${state.loginShopAppDataModel.message}',
                toastStates: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          LoginShopAppCubit cubit = LoginShopAppCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        defultText(
                          text: 'login',
                          isUpper: true,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: defultApplicationColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defultText(
                          text: 'Login now to enjoy with our hot offers.',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defultTextFormField(
                          onFieldSubmitted: () {},
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          textValidate: 'Email must be entered',
                          labelText: 'Enter your email',
                          onPressedSuffixIcon: () {},
                          prefixIconData: Icons.email,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defultTextFormField(
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userData(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: cubit.passwordVisible,
                          textValidate: 'Password must be entered',
                          labelText: 'Enter your password',
                          prefixIconData: Icons.lock,
                          suffixIconData: cubit.iconData,
                          onPressedSuffixIcon: () {
                            cubit.changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                            condition: state is! LoginLoadingDataOfShopAppState,
                            builder: (context) => defultMaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  text: 'login',
                                  isUpperCase: true,
                                ),
                            fallback: (context) =>
                                defultCircularProgressIndicator()),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defultText(
                              text: 'Don\'t have an account ?',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            defultTextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'Register Now',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
