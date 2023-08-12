import 'dart:ffi';

import 'package:e_commerce1/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  void Function(String)?onSubmit;
   
  String? errorMessage(String str) {
    switch (hint) {
       case 'Search For Products':
        return 'Search Empty!';
        case 'Phone':
        return 'phone is empty !';
       case 'Name':
        return 'Name is empty !';
      case 'Email':
        return 'Email is empty !';
      case 'Password':
        return 'Password is empty !';
      case 'Confirm Password':
        return 'Confirm Password is empty!';

      default:
        return null;
    }
  }

  CustomTextField({
    required this.icon,
    required this.hint,
    required this.controller,
    required this.keyboardType,
    this.onSubmit,
 
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      onFieldSubmitted:onSubmit ,
      controller: controller,
      validator: (value) {
        if ((value!.isEmpty)) {
          return errorMessage(hint);
          // ignore: missing_return
        }
        return null;
      },
      obscureText: hint == ' Password' ? true : false,
      cursorColor: kMainColor,
      
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: kMainColor,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: kMainColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: kMainColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: kMainColor)),
      ),
    );
  }
}
