import 'package:flutter/material.dart';
import 'package:job_test/core/utills/app_colors.dart';


class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key, required this.hintText,
    required this.selectedValue, this.items, this.onChanged,required this.enabledBorderColor});

  final String hintText;
  final String selectedValue;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final Color enabledBorderColor;
  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField(
      isExpanded: true,
      hint:Text(hintText),
      value:selectedValue,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide:BorderSide(color:enabledBorderColor, width:1), // Border color and width
          borderRadius:BorderRadius.circular(0), // Optional: for rounded corners
        ),
        focusedBorder:UnderlineInputBorder(
          borderSide:const BorderSide(color:AppColors.primary, width: 1), // Border color when focused
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }
}
