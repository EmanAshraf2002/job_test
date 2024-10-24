import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_test/componats/custom_date_textField.dart';
import 'package:job_test/componats/custom_elevated_button.dart';
import 'package:job_test/componats/custom_row_Button.dart';
import 'package:job_test/componats/custom_text_form_field.dart';
import 'package:job_test/componats/dilvery_type_widget.dart';
import 'package:job_test/core/commons.dart';
import 'package:job_test/core/routes/app_routes.dart';
import 'package:job_test/core/routes/router.dart';
import 'package:provider/provider.dart';

import '../componats/custom_loading_indicator.dart';
import '../componats/request_type_widget.dart';
import '../core/utills/app_colors.dart';
import '../core/utills/app_textStyls.dart';
import '../providers/requests_provider.dart';

class CreateRequestScreen extends StatelessWidget {
  const CreateRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final requestsProvider = Provider.of<RequestsProvider>(context);

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title:Text("Create Request",
          style: AppTextStyles.font20.copyWith(
            color: AppColors.primary,
          ),
        ),
        leading:IconButton(onPressed: (){
          navigate(context: context, route: AppRoutes.initialScreen);
        },
            icon:const Icon(Icons.arrow_back,color: AppColors.gray,size: 20,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: requestsProvider.createRequestKey,
            child: Column(
              children: [
                SizedBox(height: 40.h,),
                //Date Field
                const CustomDateTextField(),
                SizedBox(height:22.h,),
                //dropdown 1
                const RequestTypeTextField(),
                //dropdown 2
                SizedBox(height:22.h,),
                const DeliveryTypeTextField(),
                //payee name text field
                SizedBox(height: 22.h,),
                CustomTextFormField(
                    isFilled: true,
                    fillColor: AppColors.lightGray,
                    hint: "payee name",
                    validator: (data){
                      if(data!.isEmpty){
                        return "Please Enter valid payee name";
                      }
                      return null;
                    },
                    textStyle: AppTextStyles.font14,
                    textController:requestsProvider.payeeNameController,
                ),
                SizedBox(height:22.h,),
                //notes
                CustomTextFormField(hint: "notes",
                    label: "Notes",
                    isFilled: true,
                    fillColor: AppColors.lightGray,
                    validator: (data){
                      if(data!.isEmpty){
                        return "Please Enter valid notes";
                      }
                      return null;
                    },
                    textController: requestsProvider.notesController),
                //Save button
                SizedBox(height:50.h,),
                CustomElevatedButton(height:50.h,
                    width:285.w,
                    bgColor: AppColors.primary,
                    onPressed: () async {
                      if (requestsProvider.createRequestKey.currentState!.validate()) {
                        bool success;
                        if (requestsProvider.currentRequest != null) {
                          // Update existing request
                          success = await requestsProvider.updateRequest();
                          showSnackBar(context: context, message: "Your Request Updated Successfully");

                        } else {
                          // Create new request
                          success = await requestsProvider.createRequest();
                          showSnackBar(context: context, message: "Your Request Saved Successfully");
                        }
                        if(success){
                          navigate(context: context, route: AppRoutes.allRequestsScreen);
                          showSnackBar(context: context, message: "Done Successfully");
                        }else{
                          showSnackBar(context: context, message: requestsProvider.errorMessage ?? "Request failed");
                        }
                      }
                    },
                    child:requestsProvider.isLoading?
                    const CustomLoadingIndicator(indicatorColor: AppColors.white)
                    :const CustomButtonRow(
                        buttonText:"save",
                        buttonIcon:Icons.check_circle_outline))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


