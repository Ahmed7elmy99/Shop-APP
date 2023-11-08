import 'package:e_commerce1/Dio/dio%20helper.dart';
import 'package:e_commerce1/Dio/end%20point.dart';
import 'package:e_commerce1/Models/shopLoginModel.dart';
import 'package:e_commerce1/components.dart';
import 'package:e_commerce1/register/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  late shopLoginModel loginModel;
   userRegister({
    required String email,
    required String password,
     required String name,
      required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url:REGISTER, data: {'email': email, 'password': password,'name':name,'phone':phone})
        .then((value) {
    
      loginModel = shopLoginModel.fromJson(value!.data);
        printFullText(value.data);
   
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
