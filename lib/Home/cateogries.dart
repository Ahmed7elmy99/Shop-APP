import 'package:e_commerce1/Home/cubit.dart';
import 'package:e_commerce1/Home/states.dart';
import 'package:e_commerce1/Models/categoriesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<shopCubit, shopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(shopCubit.get(context).categoriesModel!.data!.data![index]),
          separatorBuilder: (context, index) => SizedBox(width: 15,),
          itemCount: shopCubit.get(context).categoriesModel!.data!.data!.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image: NetworkImage(model.image!),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          model.name!,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}