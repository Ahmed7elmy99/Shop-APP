import 'package:e_commerce1/Dio/dio%20helper.dart';
import 'package:e_commerce1/Dio/end%20point.dart';
import 'package:e_commerce1/Models/shopLoginModel.dart';
import 'package:e_commerce1/components.dart';
import 'package:e_commerce1/login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late shopLoginModel loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      //printFullText(value!.data);
      loginModel = shopLoginModel.fromJson(value!.data);
   
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
