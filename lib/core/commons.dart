import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_test/core/utills/app_textStyls.dart';
import 'package:job_test/providers/requests_provider.dart';
import 'package:provider/provider.dart';

import '../models/customer_request_model.dart';


void navigate({required context ,required String route,arguments})
{
  Navigator.pushReplacementNamed(context, route,arguments:arguments);

}


void showSnackBar({required context , required String message}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
  );
}




void showRequestTypeChoices(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
              Text("Request Type",style:AppTextStyles.font20,),
              SizedBox(height: 16.h,),
              ListTile(
                title:const Text('PMNT'),
                onTap: () {
                  Provider.of<RequestsProvider>(context, listen: false)
                      .setSelectedRTypeChoice('PMNT');
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                title:const Text('RTRN'),
                onTap: () {
                  Provider.of<RequestsProvider>(context, listen: false)
                      .setSelectedRTypeChoice('RTRN');
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                title:const Text('MTRL'),
                onTap: () {
                  Provider.of<RequestsProvider>(context, listen: false)
                      .setSelectedRTypeChoice('MTRL');
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showDeliveryTypeChoices(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
              Text("Delivery Type",style:AppTextStyles.font20,),
              SizedBox(height: 16.h,),
              ListTile(
                title:const Text('OFFICE'),
                onTap: () {
                  Provider.of<RequestsProvider>(context, listen: false)
                      .setSelectedDTypeChoice('OFFICE');
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                title:const Text('DELIVERYAGENT'),
                onTap: () {
                  Provider.of<RequestsProvider>(context, listen: false)
                      .setSelectedDTypeChoice('DELIVERYAGENT');
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
