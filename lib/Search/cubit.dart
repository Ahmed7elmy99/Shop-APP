import 'package:e_commerce1/Dio/dio%20helper.dart';
import 'package:e_commerce1/Dio/end%20point.dart';
import 'package:e_commerce1/Models/searchModel.dart';
import 'package:e_commerce1/Search/states.dart';
import 'package:e_commerce1/cache/cacheHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchshopCubit extends Cubit<SearchStates> {
  SearchshopCubit() : super(SearchShopInitialState());
  static SearchshopCubit get(context) => BlocProvider.of(context);
  SearchModel? model;
  String token = CacheHelper.getData(key: 'token');
  void Search(String text) {
    emit(SearchshopLoadingStates());
    DioHelper.postData(url: SEARCH, token: token,data: {"text": text}).then((value) {
      model = SearchModel.fromJson(value!.data);
      emit(SearchshopSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SearchshopErrorStates());
    });
  }
}
