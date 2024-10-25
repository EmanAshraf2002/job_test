import 'package:flutter/material.dart';
import 'package:job_test/core/commons.dart';
import 'package:job_test/core/routes/app_routes.dart';
import 'package:job_test/core/utills/app_colors.dart';
import 'package:job_test/core/utills/app_textStyls.dart';
import 'package:provider/provider.dart';

import '../providers/requests_provider.dart';

class CustomAlertDialog  extends StatelessWidget {
  const CustomAlertDialog({super.key, });
  @override
  Widget build(BuildContext context) {
    final request=Provider.of<RequestsProvider>(context,listen: false);
    return  AlertDialog(
      content: Text(
        "Are you sure you want"
            " to cancel your request?",style: AppTextStyles.font16,),
      actions:[
        TextButton(
            onPressed: () async{
              if (request.currentRequest != null) {
                await request.canselRequest(request.currentRequest!.id);
              } else {
                print('No request found to cancel.');
              }
             showSnackBar(context: context, message: "saved Successfully");
             navigate(context: context, route: AppRoutes.allRequestsScreen);

        },
          child: Text("confirm",
            style: AppTextStyles.font18.copyWith(color: AppColors.primary),)),
      TextButton(onPressed: () {
        Navigator.pop(context);
      },
          child: Text("cancel",
            style: AppTextStyles.font18.copyWith(color: AppColors.primary),)),
    ]
    );
  }
}
