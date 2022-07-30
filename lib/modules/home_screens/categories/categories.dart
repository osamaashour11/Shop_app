import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/categories_model/categories_model.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/shop_bloc/cubit.dart';
import 'package:flutter_shop_app/shared/shop_bloc/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoriesModel!.data!.data!.length != null,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                defultCatItem(cubit.categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.categoriesModel!.data!.data!.length,
          ),
          fallback: (context) => defultCircularProgressIndicator(),
        );
      },
    );
  }

  //  defultCatItem(cubit.categoriesModel!.data!.data![index]

  Widget defultCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image(
                image: NetworkImage(
                  '${model.image}',
                ),
                height: 100.0,
                width: 100.0,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            defultText(
              text: '${model.name}',
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
              fontSize: 20,
            ),
            const Spacer(),
            defultIconButton(
                onPressed: () {}, iconData: Icons.arrow_forward_ios)
          ],
        ),
      );
}
