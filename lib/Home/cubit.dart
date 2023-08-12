import 'dart:ffi';

import 'package:dio/dio.dart';

import 'package:e_commerce1/Dio/dio%20helper.dart';
import 'package:e_commerce1/Dio/end%20point.dart';
import 'package:e_commerce1/Home/cateogries.dart';
import 'package:e_commerce1/Home/favorite.dart';
import 'package:e_commerce1/Home/products.dart';
import 'package:e_commerce1/Home/setting.dart';
import 'package:e_commerce1/Home/states.dart';
import 'package:e_commerce1/Models/HomeModel.dart';
import 'package:e_commerce1/Models/categoriesModel.dart';
import 'package:e_commerce1/Models/chang_favoritesModel.dart';
import 'package:e_commerce1/Models/favorites.dart';
import 'package:e_commerce1/Models/shopLoginModel.dart';
import 'package:e_commerce1/cache/cacheHelper.dart';
import 'package:e_commerce1/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class shopCubit extends Cubit<shopStates> {
  shopCubit() : super(ShopInitialState());
  static shopCubit get(context) => BlocProvider.of(context);
  int CurrentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    settingScreen()
  ];
  void changBottom(int index) {
    CurrentIndex = index;
    emit(shopChangBottomNavBar());
  }

  HomeModel? homeModel;

  String token = CacheHelper.getData(key: 'token');
  Map<int, bool> favourites = {};
  Future<void> getHomeData() async {
    emit(shopLoadingHomeDataStates());
    await DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value!.data);
      print(homeModel!.status);

      //printFullText(homeModel.toString());
      //print('كله تمام ي حلومي');
      homeModel!.data!.products!.forEach((element) {
        favourites.addAll({element.id!: element.inFavorites!});
      });
      print(favourites.toString());
      emit(shopSuccessHomeDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorHomeDataStates());
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;

  Future<void> getCategories() async {
    await DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value!.data);

      //printFullText(homeModel.toString());
      //print('كله تمام ي حلومي');
      emit(ShopGetCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetCategoriesErrortate());
      print(error.toString());
    });
  }

  shopLoginModel? usermodel;
  Future<Response<dynamic>?> getProfileData() async {
    emit(ShopFavoritesLoadingState());
    await DioHelper.getData(url: PROFILE, token: token).then((value) {
      usermodel = shopLoginModel.fromJson(value!.data);
      //  print(usermodel!.data!.name);

      emit(ShopProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopProfileErrortate());
    });
  }

  ChangFavoritesModel? changFavoritesModel;
  void changFavorite(int productId) {
    
    favourites[productId] = !favourites[productId]!;
    emit(ShopFavoritesLoadingState());
    emit(ShopFavoritestate());
    DioHelper.postData(
            url: FAVORITE, data: {"product_id": productId}, token: token)
        .then((value) {
      changFavoritesModel = ChangFavoritesModel.fromJson(value!.data);
      if (!changFavoritesModel!.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavorites();
      }
      print(value.data);
      emit(ShopFavoriteSuccessState(changFavoritesModel!));
    }).catchError((error) {
      emit(ShopFavoriteErrortate());
      print(error.toString());
    });
  }

  Future<Response<dynamic>?> UpdateProfileData({
    required String email,
    required String name,
    required String phone,
  }) async {
    emit(ShopFavoritesLoadingState());
    await DioHelper.PutData(
        url: UpdateProfile,
        token: token,
        data: {"email": email, "phone": phone, "name": name}).then((value) {
      usermodel = shopLoginModel.fromJson(value!.data);
      // print(usermodel!.data!.name);

      emit(ShopUpdateProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateProfileErrortate());
    });
  }

  FavoritesModel? favoritesModel;

  Future<void> getFavorites() async {
    await DioHelper.getData(
      url: FAVORITE,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value!.data);

      printFullText(value.data.toString());
      //print('كله تمام ي حلومي');
      emit(ShopGetFavouritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavoritesErrortate());
      print(error.toString());
    });
  }
}
