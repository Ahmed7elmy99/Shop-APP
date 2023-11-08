import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce1/Home/home.dart';
import 'package:e_commerce1/cache/cacheHelper.dart';
import 'package:e_commerce1/components.dart';

import 'package:e_commerce1/constants/constants.dart';
import 'package:e_commerce1/login/cubit/cubit.dart';
import 'package:e_commerce1/login/cubit/states.dart';
import 'package:e_commerce1/register/shop%20register.dart';
import 'package:e_commerce1/widgets/Text%20Form%20Field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token!;
              navigateAndFinish(context,const productScreen());
        
              });
              showToast(
                Text: state.loginModel.message,
                state: ToastStates.SUCCESS,
              );
            } else {
              print(state.loginModel.message);
              showToast(
                Text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            backgroundColor: kMainColor,
            title:const Text('Login'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
               const         SizedBox(
                          height: 30.0,
                        ),
                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email,
                        hint: 'Email',
                        controller: emailController,
                      ),
                  const    SizedBox(height: 16),
                      CustomTextField(
                        keyboardType: TextInputType.visiblePassword,
                        icon: Icons.lock,
                        hint: 'Password',
                        controller: passwordController,
                      ),
                  const    SizedBox(height: 16),
                      ConditionalBuilder(
                        condition: !(state is ShopLoginLoadingState),
                        builder: (context) => ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kMainColor),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          child:const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        fallback: (context) =>const CircularProgressIndicator(),
                      ),
                 const     SizedBox(height: 16),
                      Row(
                        children: [


                       const   Text("   'Don\'t have an account?",
                              style: TextStyle(
                                color: kMainColor,
                                fontWeight: FontWeight.bold,
                              ),),
                       const       SizedBox(width: 30,),
                          TextButton(
                            onPressed: () {
                             navigateAndFinish(context, SignupScreen())
                              ;
                            },
                            child:const Text(
                           '       Sign up',
                              style: TextStyle(
                                color: kMainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
