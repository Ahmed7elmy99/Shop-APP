import 'package:e_commerce1/Home/cubit.dart';

import 'package:e_commerce1/Home/states.dart';
import 'package:e_commerce1/Search/searchScreen.dart';
import 'package:e_commerce1/cache/cacheHelper.dart';
import 'package:e_commerce1/constants/constants.dart';

import 'package:e_commerce1/login/shop%20login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class productScreen extends StatelessWidget {
  const productScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = shopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kMainColor,
            title: Text('Salla'),
            actions: [IconButton(icon: Icon(Icons.search),onPressed: (){
               Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => searchScreen()),
      );
            },)],

          ),
          body: cubit.bottomScreens[cubit.CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
             backgroundColor: Colors.blue,
  selectedItemColor: Colors.black,
  unselectedItemColor: Colors.blue,
  selectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            onTap: (index) {
              cubit.changBottom(index);
            },
            currentIndex: cubit.CurrentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.black,), label:'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps,color: Colors.black,), label: 'Cateogries'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite,color: Colors.black,), label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings,color: Colors.black,), label: 'Settings'),
            ],
         
          ),
        );
      },
    );
  }
}
