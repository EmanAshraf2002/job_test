import 'package:flutter/material.dart';
import 'package:job_test/core/utills/app_colors.dart';
import 'package:job_test/core/utills/app_textStyls.dart';

class RequestsTextField  extends StatelessWidget {
  const RequestsTextField({super.key, required this.labelText, this.onPressed,
     required this.textController, required this.suffix, this.validator});

  final TextEditingController textController;
  final String labelText;
  final void Function()? onPressed;
  final Widget suffix;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      validator:validator ,
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightGray,
        labelText: labelText,
        labelStyle:AppTextStyles.font16.copyWith(
          fontWeight: FontWeight.w300,
        ),
        suffixIcon: suffix,
        enabledBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color:AppColors.gray),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color:AppColors.primary),
        ),
      ),
      style:AppTextStyles.font14,
    );
  }
}
