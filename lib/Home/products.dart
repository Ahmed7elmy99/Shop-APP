import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce1/Home/cubit.dart';
import 'package:e_commerce1/Home/states.dart';
import 'package:e_commerce1/Models/HomeModel.dart';
import 'package:e_commerce1/Models/categoriesModel.dart';
import 'package:e_commerce1/Models/shopLoginModel.dart';
import 'package:e_commerce1/components.dart';
import 'package:e_commerce1/constants/constants.dart';
import 'package:e_commerce1/login/cubit/cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopStates>(
      listener: (context, state) {
        if (state is ShopFavoriteSuccessState) {
          if (!state.changFavoritesModel.status!) {
           showToast(
                Text: state.changFavoritesModel.message,
                state: ToastStates.ERROR,
              );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: shopCubit.get(context).homeModel != null &&
              shopCubit.get(context).categoriesModel != null,
          builder: (context) => productsBuilder(
            shopCubit.get(context).homeModel!,
            context,
            shopCubit.get(context).categoriesModel!,
            MediaQuery.of(context).size.width,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, context,
          CategoriesModel categoriesModel, double screenWidth) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners!
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: screenWidth * 0.5,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Container(
                height: 200,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoriesModel.data!.data![index]),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 15,
                        ),
                    itemCount: categoriesModel.data!.data!.length)),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "New Products",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Container(
              color: Colors.grey[200],
              child: GridView.count(
                mainAxisSpacing: 2,
                childAspectRatio: 1 / 1.65,
                crossAxisSpacing: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: screenWidth > 600
                    ? 4
                    : 2, // Adjust the number of columns based on screen width
                children: List.generate(
                  model.data!.products!.length,
                  (index) =>
                      buildGridProduct(model.data!.products![index], context),
                ),
              ),
            )
          ],
        ),
      );
  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
              height: 200,
              width: 200,
              image: NetworkImage(
                (model.image!),
              )),
          Container(
              width: 200,
              color: Colors.black,
              child: Text(
                model.name!,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))
        ],
      );
  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "${model.price.round()}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                SizedBox(
                  width: 30,
                ),
                if (model.discount != 0)
                  Text(
                    "${model.oldPrice.round()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    print(model.id);
                    shopCubit.get(context).changFavorite(model.id!);
                  },
                  icon: CircleAvatar(
                      backgroundColor:
                          shopCubit.get(context).favourites[model.id!]!
                              ? kMainColor
                              : Colors.grey,
                      radius: 15,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 20,
                      )),
                ),
              ],
            )
          ],
        ),
      );
}
