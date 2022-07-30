import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/modules/login_screen/Login_screen.dart';
import 'package:flutter_shop_app/modules/register_screen/register_cubit/register_cubit.dart';
import 'package:flutter_shop_app/modules/register_screen/register_cubit/register_states.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/constants/constants.dart';
import 'package:flutter_shop_app/shared/network/local/shared_preferences/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterShopAppCubit(),
      child: BlocConsumer<RegisterShopAppCubit, RegisterShopAppStates>(
        listener: (context, state) {
          if (state is RegisterGetSuccessDataOfShopAppState) {
            if (state.loginShopAppDataModel.status == true) {
              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginShopAppDataModel.data!.token)
                  .then((value) {
                token = state.loginShopAppDataModel.data!.token;
                navigateAndFinish(context, LoginScreen());
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
          var cubit = RegisterShopAppCubit.get(context);

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
                          text: 'register',
                          isUpper: true,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: defultApplicationColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defultText(
                          text: 'Register now to enjoy with our hot offers.',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defultTextFormField(
                          onFieldSubmitted: () {},
                          controller: nameController,
                          textInputType: TextInputType.name,
                          textValidate: 'Name must be entered',
                          labelText: 'Enter your name',
                          onPressedSuffixIcon: () {},
                          prefixIconData: Icons.person,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defultTextFormField(
                          onFieldSubmitted: () {},
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          textValidate: 'Phone must be entered',
                          labelText: 'Enter your phone',
                          onPressedSuffixIcon: () {},
                          prefixIconData: Icons.phone_android,
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
                          onFieldSubmitted: () {},
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
                            condition: state is! RegisterLoadingDataOfShopAppState,
                            builder: (context) => defultMaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  text: 'register',
                                  isUpperCase: true,
                                ),
                            fallback: (context) =>
                                defultCircularProgressIndicator()),
                        const SizedBox(
                          height: 20,
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
