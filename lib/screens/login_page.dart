import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_test/componats/custom_elevated_button.dart';
import 'package:job_test/componats/custom_loading_indicator.dart';
import 'package:job_test/componats/custom_text_form_field.dart';
import 'package:job_test/core/commons.dart';
import 'package:job_test/core/routes/app_routes.dart';
import 'package:job_test/core/utills/app_assets.dart';
import 'package:job_test/core/utills/app_colors.dart';
import 'package:job_test/core/utills/app_textStyls.dart';
import 'package:job_test/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../componats/custom_image_container.dart';
import '../componats/custom_row_Button.dart';


class LoginScreen  extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title:Text("Accurate(Business)",
          style: AppTextStyles.font20.copyWith(
          color: AppColors.primary,
        ),
        ),
        leading:IconButton(onPressed: (){},
            icon:const Icon(Icons.arrow_back,color: AppColors.gray,size: 20,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Form(
            key:authProvider.loginKey ,
            child: Column(
              children: [
                CustomImageContainer(height: 170.h,width: 200.w,
                  fit:BoxFit.fill,
                  imagePathString: AppAssets.primaryImage,),
                 SizedBox(height: 50.h,),
                CustomTextFormField(hint: "اسم المستخدم / البريد الالكتروني",
                    textStyle: AppTextStyles.font14.copyWith(color: AppColors.gray),
                    textController:authProvider.userNameController,
                    prefixIcon: const Icon(Icons.person,color:AppColors.gray,size: 20,),
                    validator: (data){
                     if(data!.isEmpty ){
                          return "Please Enter Valid Email" ;
                      }
                      return null;
                    },
                ),
                SizedBox(height: 20.h,),
                CustomTextFormField(hint: "كلمة المرور",
                  textStyle: AppTextStyles.font14.copyWith(color: AppColors.gray),
                  textController:authProvider.passwordController,
                  prefixIcon: const Icon(Icons.key,color:AppColors.gray,size: 20,),
                  suffixIcon:IconButton(
                    onPressed: (){
                     authProvider.changePasswordSuffixIcon();
                  },
                    icon:Icon(authProvider.suffixIcon ,color:AppColors.gray,size:20,),),
                  isPassword:authProvider.isPasswordSecured,
                  validator: (data){
                    if(data!.isEmpty || data.length < 6){
                      return "Please Enter Valid password" ;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50.h,),
                CustomElevatedButton(
                    height:50.h,
                    width:285.w,
                    bgColor: AppColors.primary,
                   onPressed: () async{
                       if(authProvider.loginKey.currentState!.validate()){
                         bool loginSuccessful=await authProvider.Login();
                         if(loginSuccessful){
                           navigate(context: context, route: AppRoutes.createRequestScreen);
                           showSnackBar(context:context,
                           message:"Login Successfully",);
                         }
                        else{
                           showSnackBar(context:context,
                             message:authProvider.errorMessage ?? "Login failed",);
                         }

                       }
                     },
                   child:authProvider.isLoading?
                   const CustomLoadingIndicator(indicatorColor: AppColors.white):
                   const CustomButtonRow(buttonText:"تسجيل الدخول",
                     buttonIcon:Icons.lock,),
                ),
                SizedBox(height:40.h,),
                CustomElevatedButton(
                    height:50.h,
                    width:285.w,
                    bgColor: AppColors.gray2,
                    child:
                    const CustomButtonRow(buttonText:"انشاء حساب جديد",
                      buttonIcon:Icons.add_circle_outline)
                ),
                SizedBox(height: 12.h,),
                TextButton(onPressed: (){},
                    child: Text("هل نسيت كلمة المرور؟",
                      style: AppTextStyles.font16.copyWith(
                        fontWeight: FontWeight.w300,
                        color: AppColors.primary,
                      ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


