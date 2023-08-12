

import 'package:e_commerce1/Models/shopLoginModel.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final shopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
  
}

