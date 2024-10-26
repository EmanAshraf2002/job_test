import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_test/core/commons.dart';
import 'package:job_test/core/routes/app_routes.dart';
import 'package:job_test/models/customer_request_model.dart';

class RequestItem  extends StatelessWidget {
  const RequestItem({super.key, required this.customerRequestModel,required this.index});

 final CustomerRequestModel customerRequestModel;
 final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
         navigate(context: context, route: AppRoutes.requestDetailsScreen,
          arguments:customerRequestModel);
        },
      title:Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(index.toString()),
            SizedBox(height: 5.h,),
             Row(
              mainAxisSize:MainAxisSize.min,
              children: [
               const Icon(Icons.shopping_bag_outlined,size: 18,),
               Text(customerRequestModel.status)
            ],
            ),
          ],
        ),
      ),
      trailing: Text(customerRequestModel.date.toString()),
    );
  }
}
