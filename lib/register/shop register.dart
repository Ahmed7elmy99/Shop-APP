import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce1/cache/cacheHelper.dart';
import 'package:e_commerce1/components.dart';
import 'package:e_commerce1/constants/constants.dart';
import 'package:e_commerce1/login/shop%20login.dart';
import 'package:e_commerce1/register/cubit/cubit.dart';
import 'package:e_commerce1/register/cubit/states.dart';
import 'package:e_commerce1/widgets/Text%20Form%20Field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController password = TextEditingController();

  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
            listener: (context, state) {
              if (state is ShopRegisterSuccessState) {
                if (state.loginModel.status!) {
                  print(state.loginModel.message);
                  print(state.loginModel.data!.token);
                  CacheHelper.saveData(
                    key: 'token',
                    value: state.loginModel.data!.token,
                  );
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
                    title: const Text('Sign up'),
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                   Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                                color: Colors.black,
                                fontSize: 25,fontWeight: FontWeight.bold
                              ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                    const    SizedBox(
                          height: 30.0,
                        ),
                                CustomTextField(
                                    keyboardType: TextInputType.name,
                                    icon: Icons.person,
                                    hint: 'Name',
                                    controller: name),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  keyboardType: TextInputType.emailAddress,
                                  icon: Icons.email,
                                  hint: 'Email',
                                  controller: email,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  icon: Icons.lock,
                                  hint: 'Password',
                                  controller: password,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                    keyboardType: TextInputType.phone,
                                    icon: Icons.phone,
                                    hint: 'Phone',
                                    controller: phone),
                                const SizedBox(height: 16),
                                  ConditionalBuilder(
                        condition: !(state is ShopRegisterLoadingState),
                        builder: (context) =>
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              kMainColor),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                  await      ShopRegisterCubit.get(context)
                                            .userRegister(
                                                name: name.text,
                                                email: email.text,
                                                password: password.text,
                                                phone: phone.text);
                                      }
                                    },
                                    child:const Center(
                                      child:  Text(
                                        'Sign up',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  
                                    ),
                                       fallback: (context) =>const CircularProgressIndicator(),),
                                const SizedBox(height: 16),
                                  Row(
                        children: [


                     const     Text("   Already Have Account?",
                              style: TextStyle(
                                color: kMainColor,
                                fontWeight: FontWeight.bold,
                              ),),
                        const      SizedBox(width: 30,),
                          TextButton(
                            onPressed: () {
                            navigateAndFinish(context, LoginScreen());
                            },
                            child:const Text(
                           '        Return To Login',
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
                )));
  }
}
