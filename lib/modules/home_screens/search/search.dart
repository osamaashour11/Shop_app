import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/search_model/search_model.dart';
import 'package:flutter_shop_app/modules/home_screens/search/search_cubit/cubit.dart';
import 'package:flutter_shop_app/modules/home_screens/search/search_cubit/states.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/constants/constants.dart';
import 'package:flutter_shop_app/shared/shop_bloc/cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchShopAppCubit(),
      child: BlocConsumer<SearchShopAppCubit, SearchShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defultTextFormField(
                      controller: searchController,
                      textValidate: 'Please enter data to start searching...',
                      onChanged: (text) {
                        SearchShopAppCubit.get(context).searchData(text);
                      },
                      labelText: 'Search...',
                      onPressedSuffixIcon: () {},
                      prefixIconData: Icons.search,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is LoadingSearchShopAppState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SuccessSearchShopAppState)
                      Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => defultFavouriteItem(
                            SearchShopAppCubit.get(context)
                                .searchModel!
                                .data!
                                .data![index],
                            context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchShopAppCubit.get(context)
                            .searchModel!
                            .data!
                            .data!
                            .length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget defultFavouriteItem(Product model, context) => Padding(
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
                      '${model.image}',
                    ),
                    height: 120.0,
                    width: 120.0,
                  ),
                  if (model.discount != 0)
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
                      text: '${model.name}',
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
                          text: '${model.price.toString()} LE',
                          color: defultApplicationColor,
                          fontSize: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (1 != 0)
                          defultText(
                            text: '${model.oldPrice.toString()} LE',
                            color: Colors.grey,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                          ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopAppCubit.get(context).favorites[model.id!]!
                                  ? defultApplicationColor
                                  : Colors.grey,
                          child: defultCatIconButton(
                            onPressed: () {
                              ShopAppCubit.get(context)
                                  .changeFavorites(model.id!);
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
