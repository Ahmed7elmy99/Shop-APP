import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce1/Home/cubit.dart';
import 'package:e_commerce1/Home/states.dart';
import 'package:e_commerce1/Models/favorites.dart';
import 'package:e_commerce1/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<shopCubit, shopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
   return   ConditionalBuilder(condition: shopCubit.get(context).favoritesModel!=null, builder: (context)=>  ListView.separated(
          itemBuilder: (context,index) => buildFavItem(shopCubit.get(context).favoritesModel!.data!.data![index].product!,context),
          separatorBuilder: (context, index) =>const SizedBox(height: 5,),
          itemCount: shopCubit.get(context).favoritesModel!.data!.data!.length,
        ), fallback: ( context) =>const Center(child: CircularProgressIndicator()));});
      
      }
  }

  Widget buildFavItem(Product model,context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image.network(
                 model.image!,
                    width: 150, // Adjust the width as needed
                    height: 150, // Adjust the height as needed
                  ),
                  if(model.discount!=0)
                  Container(
                    color: Colors.red,
                    padding:const EdgeInsets.symmetric(horizontal: 5),
                    child:const Text(
                      "DISCOUNT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            const  SizedBox(width: 10), // Adjust the width as needed
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
             const       Spacer(),
                    Row(
                      children: [
                        Text(
                        model.price.toString()
                         , style:const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                   const     SizedBox(width: 10), // Adjust the width as needed
                              if(model.discount!=0)
                          Text(
                          model.oldPrice.toString(),
                            style:const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                   const     Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            //print(model.id);
                            shopCubit.get(context).changFavorite(model.id!);
                          },
                          icon: CircleAvatar(
                            backgroundColor:   shopCubit.get(context).favourites[model.id]!
                              ? kMainColor
                              : Colors.grey,
                            radius: 15,
                            child:const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 20,
                            ),
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
      

