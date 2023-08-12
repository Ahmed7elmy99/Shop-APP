import 'package:e_commerce1/cache/cacheHelper.dart';
import 'package:e_commerce1/constants/constants.dart';
import 'package:e_commerce1/login/shop%20login.dart';
import 'package:flutter/material.dart';

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({super.key});
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("OnBoarding Screen")),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kMainColor),
            ),
            onPressed: () async {
               CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
            },
            child: Text(
              'skip',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
