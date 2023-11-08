// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce1/Models/onBoardingModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce1/Dio/dio%20helper.dart';
import 'package:e_commerce1/Home/cubit.dart';
import 'package:e_commerce1/Home/home.dart';
import 'package:e_commerce1/Models/HomeModel.dart';
import 'package:e_commerce1/cache/cacheHelper.dart';
import 'package:e_commerce1/login/cubit/bloc%20observer.dart';
import 'package:e_commerce1/login/cubit/cubit.dart';
import 'package:e_commerce1/login/shop%20login.dart';
import 'package:e_commerce1/onBoarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');
  print(token);
  Widget widget;
  if (onBoardingScreen != null) {
    if (token != null)
      widget = productScreen();
    else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    onBoarding: onBoarding,
    startWiget: widget,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    required this.onBoarding,
    required this.startWiget,
  }) : super(key: key);

  final bool onBoarding;
  final Widget startWiget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => shopCubit()
                ..getHomeData()
                ..getProfileData()
                ..getCategories()..getFavorites()

                )
        ],
        child: MaterialApp(
          home: startWiget,
          debugShowCheckedModeBanner: false,
        ));
  }
}
