import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/constants/constants.dart';
import 'package:flutter_shop_app/shared/shop_bloc/cubit.dart';
import 'package:flutter_shop_app/shared/shop_bloc/states.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);

        nameController.text = cubit.userDataModel!.data!.name!;
        emailController.text = cubit.userDataModel!.data!.email!;
        phoneController.text = cubit.userDataModel!.data!.phone!;

        return ConditionalBuilder(
          condition: cubit.userDataModel!.data != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defultTextFormField(
                        controller: nameController,
                        textValidate: 'Name must be entered !',
                        onFieldSubmitted: () {},
                        labelText: 'Name',
                        onPressedSuffixIcon: () {},
                        prefixIconData: Icons.person,
                        textInputType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      defultTextFormField(
                        controller: emailController,
                        textValidate: 'Email must be entered !',
                        onFieldSubmitted: () {},
                        labelText: 'Email',
                        onPressedSuffixIcon: () {},
                        prefixIconData: Icons.email,
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      defultTextFormField(
                        controller: phoneController,
                        textValidate: 'Phone must be entered !',
                        onFieldSubmitted: () {},
                        labelText: 'Phone',
                        onPressedSuffixIcon: () {},
                        prefixIconData: Icons.phone_android,
                        textInputType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopUpdateDataOfShopAppState,
                        builder: (context) => defultMaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'update',
                          isUpperCase: true,
                        ),
                        fallback: (context) => Row(
                          children: [
                            const Expanded(child: LinearProgressIndicator()),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: defultText(text: 'Updating'),
                            ),
                            const Expanded(child: LinearProgressIndicator()),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      defultMaterialButton(
                        onPressed: () {
                          signOut(context);
                        },
                        text: 'Logout',
                        isUpperCase: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => defultCircularProgressIndicator(),
        );
      },
    );
  }
}
