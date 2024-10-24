import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_test/core/utills/app_textStyls.dart';

import '../core/utills/app_colors.dart';

class CustomButtonRow extends StatelessWidget {
  const CustomButtonRow({
    super.key, required this.buttonText, required this.buttonIcon,
  });

  final String buttonText;
  final IconData buttonIcon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(buttonText,
          style: AppTextStyles.font18.copyWith(color:AppColors.white),),
        SizedBox(width: 10.w,),
        Icon(buttonIcon,color:AppColors.white,size: 30,),
      ],
    );
  }
}
