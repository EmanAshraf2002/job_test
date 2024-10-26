import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_test/core/cachehelper/cache_helper.dart';
import 'package:job_test/core/routes/app_routes.dart';
import 'package:job_test/core/utills/app_colors.dart';

import '../componats/custom_image_container.dart';
import '../core/commons.dart';
import '../core/utills/app_assets.dart';

class SplashScreen  extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNewPage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.bgColor,
      body:Center(
        child:  CustomImageContainer(height: 170.h,width: 200.w,
          fit:BoxFit.fill,
          imagePathString: AppAssets.primaryImage,),
      ) ,
    );
  }

  void navigateToNewPage() async{
    await Future.delayed(const Duration(seconds:2)).then((value) async{
      await CacheHelper().getData(key:'token')!=null?
      navigate(context: context, route: AppRoutes.loginScreen):
      navigate(context: context, route: AppRoutes.createRequestScreen) ;

    });
  }
}
