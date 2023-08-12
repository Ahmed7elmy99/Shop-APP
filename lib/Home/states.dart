import 'package:e_commerce1/Models/chang_favoritesModel.dart';
import 'package:e_commerce1/login/cubit/states.dart';

abstract class shopStates {}

class ShopInitialState extends shopStates {}

class shopChangBottomNavBar extends shopStates {}

class shopLoadingHomeDataStates extends shopStates {}

class shopSuccessHomeDataStates extends shopStates {}

class shopErrorHomeDataStates extends shopStates {}

class ShopProfileLoadingState extends shopStates {}

class ShopProfileSuccessState extends shopStates {}

class ShopProfileErrortate extends shopStates {}

class ShopUpdateProfileLoadingState extends shopStates {}

class ShopUpdateProfileSuccessState extends shopStates {}

class ShopUpdateProfileErrortate extends shopStates {}

class ShopGetCategoriesSuccessState extends shopStates {}

class ShopGetCategoriesErrortate extends shopStates {}

class ShopFavoriteSuccessState extends shopStates {
  final ChangFavoritesModel changFavoritesModel;
  ShopFavoriteSuccessState(this.changFavoritesModel);
}

class ShopFavoriteErrortate extends shopStates {}

class ShopFavoritestate extends shopStates {}

class ShopGetFavouritesSuccessState extends shopStates {}

class ShopGetFavoritesErrortate extends shopStates {}

class ShopFavoritesLoadingState extends shopStates {}
