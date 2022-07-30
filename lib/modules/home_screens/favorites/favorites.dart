import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/favorites_model/favorites_model.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/constants/constants.dart';
import 'package:flutter_shop_app/shared/shop_bloc/cubit.dart';
import 'package:flutter_shop_app/shared/shop_bloc/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition:  cubit.favoritesModel!.data!.data != null,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => defultFavouriteItem(
                cubit.favoritesModel!.data!.data![index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => defultCircularProgressIndicator(),
        );
      },
    );
  }

  Widget defultFavouriteItem(FavData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      '${model.product!.image}',
                    ),
                    height: 120.0,
                    width: 120.0,
                  ),
                  if (model.product!.discount != 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child:
                              defultText(text: 'DISCOUNT', color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defultText(
                      text: '${model.product!.name}',
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        defultText(
                          text: '${model.product!.price.toString()} LE',
                          color: defultApplicationColor,
                          fontSize: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (1 != 0)
                          defultText(
                            text: '${model.product!.oldPrice.toString()} LE',
                            color: Colors.grey,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                          ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopAppCubit.get(context)
                                  .favorites[model.product!.id!]!
                              ? defultApplicationColor
                              : Colors.grey,
                          child: defultCatIconButton(
                            onPressed: () {
                              ShopAppCubit.get(context)
                                  .changeFavorites(model.product!.id!);
                            },
                            iconData: Icons.favorite_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
