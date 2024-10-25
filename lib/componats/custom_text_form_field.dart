import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utills/app_colors.dart';

class CustomTextFormField  extends StatelessWidget {
  const CustomTextFormField({super.key,
    required this.hint, this.label,
    required this.textController,
    this.isPassword=false,
    this.validator, this.prefixIcon, this.suffixIcon, this.textStyle,
    this.isFilled=false,this.fillColor,this.labelStyle});
  final String hint;
  final String? label;
  final TextEditingController textController;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final bool isFilled;
  final Color? fillColor;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primary,
      controller: textController,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled:isFilled,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon:suffixIcon ,
        hintText: hint,
        hintStyle:textStyle ,
        labelText: label,
        labelStyle: labelStyle,
        contentPadding: EdgeInsetsDirectional.symmetric(vertical: 18.h, horizontal: 22.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide:const BorderSide(color:AppColors.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide:const BorderSide(color:AppColors.gray),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:const BorderSide(color:AppColors.primary),
          borderRadius: BorderRadius.circular(8.r), ),
      ),
    );
  }
}
