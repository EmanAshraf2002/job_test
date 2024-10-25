import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:job_test/componats/custom_alert_dialog.dart';
import 'package:job_test/componats/custom_elevated_button.dart';
import 'package:job_test/core/commons.dart';
import 'package:job_test/core/routes/app_routes.dart';
import 'package:job_test/core/utills/app_colors.dart';
import 'package:job_test/core/utills/app_textStyls.dart';
import 'package:job_test/models/customer_request_model.dart';
import 'package:provider/provider.dart';
import '../componats/custom_loading_indicator.dart';
import '../componats/custom_row_Button.dart';
import '../providers/requests_provider.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key, required this.requestModel});
  final CustomerRequestModel requestModel;

  @override

  Widget build(BuildContext context) {
    final requestsProvider = Provider.of<RequestsProvider>(context);
    DateTime dateTime = DateTime.parse(requestModel.date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: AppColors.bgColor,
        title:Text("Request Details",
          style: AppTextStyles.font20.copyWith(
            color: AppColors.primary,
          ),
        ),
        leading:IconButton(onPressed: (){
          navigate(context: context, route: AppRoutes.allRequestsScreen);
        },
            icon:const Icon(Icons.arrow_back,color: AppColors.gray,size: 20,)),
        actions: [
          requestModel.status!='CANCELLED'?
          IconButton(onPressed:(){
            requestsProvider.fillRequestData(requestModel) ;
            navigate(context: context, route: AppRoutes.createRequestScreen);
          }, icon:const Icon(Icons.edit,color: AppColors.gray,size: 20,)):
          const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(18),
          child: Column(
            children: [
              Text("Request ${requestModel.id}",style:AppTextStyles.font16,),
              SizedBox(height: 22.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.shopping_bag_outlined),
                  Text("Request Details",style:AppTextStyles.font16,),
                ],
              ),
              SizedBox(height:10.h,),
              Container(
                height:280.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.lightGray,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                         const Text("Status"),
                         Text(requestModel.status) ,
                          SizedBox(height: 14.h,),
                          const Text("Date"),
                          Text(formattedDate) ,
                          SizedBox(height: 14.h,),
                          const Text("Delivery Type"),
                          Text(requestModel.deliveryTypeCode) ,
                          SizedBox(height: 14.h,),
                          const Text("Notes"),
                          Text(requestModel.notes ?? "No Notes") ,
                          SizedBox(height: 14.h,),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("payee name"),
                          Text(requestModel.payeeName) ,
                          SizedBox(height: 14.h,),
                          const Text("Time"),
                          Text(formattedTime) ,
                          SizedBox(height: 14.h,),
                          const Text("Request Type"),
                          Text(requestModel.typeCode) ,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height:50.h,),
              requestModel.status!='CANCELLED'?
              CustomElevatedButton(
                  height:50.h,
                  width:285.w,
                  bgColor: AppColors.primary,
                  onPressed: () {
                     requestsProvider.setCurrentRequest(requestModel);
                      showDialog(context: context, builder: (context){
                         return const CustomAlertDialog();
                      });
                  },
                  child:requestsProvider.isLoading?
                  const CustomLoadingIndicator(indicatorColor: AppColors.white):
                  const CustomButtonRow(buttonText:"cancel",
                      buttonIcon:Icons.cancel_outlined)
              ):const SizedBox(),



            ],
    )
          ),
        ),
    );
  }
}
