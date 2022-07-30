import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/categories_model/categories_model.dart';
import 'package:flutter_shop_app/models/home_model/home_model.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/constants/constants.dart';
import 'package:flutter_shop_app/shared/shop_bloc/cubit.dart';
import 'package:flutter_shop_app/shared/shop_bloc/states.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => productItemBuilder(
              cubit.homeModel!, cubit.categoriesModel!, context),
          fallback: (context) => defultCircularProgressIndicator(),
        );
      },
    );
  }

  Widget productItemBuilder(
          HomeModel homeModel, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel.data!.banners!
                  .map(
                    (e) => Image(
                      image: NetworkImage(
                        '${e.image}',
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 200,
                initialPage: 0,
                autoPlay: true,
                enableInfiniteScroll: true,
                reverse: false,
                // autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            const SizedBox(
              height: 10.00,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defultText(
                      text: 'Categories',
                      fontSize: 25,
                      color: defultApplicationColor),
                  const SizedBox(
                    height: 20.00,
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => defultCategoryItem(
                          categoriesModel.data!.data![index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel.data!.data!.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20.00,
                  ),
                  defultText(
                      text: 'New Products',
                      fontSize: 25,
                      color: defultApplicationColor),
                  const SizedBox(
                    height: 20.00,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.52,
                children: List.generate(
                  homeModel.data!.products!.length,
                  (index) => defultGridProductItem(
                      homeModel.data!.products![index], context),
                ),
              ),
            ),
          ],
        ),
      );
}

HomeModel? customModel;
Widget defultGridProductItem(ProductsModel homeModel, context) => Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Center(
                  child: Image(
                    image: NetworkImage(
                      '${homeModel.image}',
                    ),
                    width: 180,
                    height: 180,
                  ),
                ),
                if (homeModel.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defultText(
                      text: '${homeModel.name}',
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        defultText(
                          text: '${homeModel.price.round()} LE',
                          color: defultApplicationColor,
                          fontSize: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (homeModel.discount != 0)
                          defultText(
                            text: '${homeModel.oldPrice.round()} LE',
                            color: Colors.grey,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                          ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopAppCubit.get(context).favorites[homeModel.id]!
                                  ? defultApplicationColor
                                  : Colors.grey,
                          child: defultCatIconButton(
                            onPressed: () {
                              ShopAppCubit.get(context)
                                  .changeFavorites(homeModel.id!);
                            },
                            iconData: Icons.favorite_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
Widget defultCategoryItem(DataModel model) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
              '${model.image}',
            ),
            height: 120.0,
            width: 120.0,
          ),
          Container(
            width: 120.00,
            color: Colors.black.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: defultText(
                text: '${model.name}',
                textAlign: TextAlign.center,
                fontSize: 15,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
