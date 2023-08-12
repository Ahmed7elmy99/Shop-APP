import 'package:e_commerce1/Models/shopLoginModel.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final shopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
  
}
