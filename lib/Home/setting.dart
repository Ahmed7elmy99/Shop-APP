import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce1/Home/cubit.dart';
import 'package:e_commerce1/Home/states.dart';
import 'package:e_commerce1/components.dart';
import 'package:e_commerce1/constants/constants.dart';
import 'package:e_commerce1/widgets/Text%20Form%20Field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class settingScreen extends StatelessWidget {
  settingScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopStates>(
      listener: (context, state) {
        if (state is ShopFavoriteSuccessState) {
          Fluttertoast.showToast(
            msg: "Profile updated successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        }
      },
      builder: (context, state) {
        var model = shopCubit.get(context).usermodel;
        if (model != null && model.data != null) {
          email.text = model.data!.email ?? '';
          name.text = model.data!.name ?? '';
          phone.text = model.data!.phone ?? '';
        }

        return ConditionalBuilder(
            condition: shopCubit.get(context).homeModel != null,
            builder: (context) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (state is ShopFavoritesLoadingState)
                            LinearProgressIndicator(),
                          const SizedBox(height: 16),
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
                              keyboardType: TextInputType.phone,
                              icon: Icons.phone,
                              hint: 'Phone',
                              controller: phone),
                          const SizedBox(height: 16),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kMainColor),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  shopCubit.get(context).UpdateProfileData(
                                      email: email.text,
                                      name: name.text,
                                      phone: phone.text);
                                }
                              },
                              child: const Text(
                                'UPDATE',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kMainColor),
                              ),
                              onPressed: () async {
                                signOut(context);
                              },
                              child: const Text(
                                'LOGOUT',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
            fallback: (BuildContext context) =>
                Center(child: CircularProgressIndicator()));
      },
    );
  }
}
