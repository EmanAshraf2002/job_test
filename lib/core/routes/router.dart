import 'package:flutter/material.dart';
import 'package:job_test/core/routes/app_routes.dart';
import 'package:job_test/models/customer_request_model.dart';
import 'package:job_test/screens/all_requests.dart';
import 'package:job_test/screens/create_request.dart';
import 'package:job_test/screens/login_page.dart';
import 'package:job_test/screens/request_details.dart';
import 'package:job_test/screens/splash_screen.dart';

class AppRouter{

  static Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case AppRoutes.initialScreen:
        return MaterialPageRoute(builder: (context)=>const SplashScreen());
      case AppRoutes.loginScreen:
        return MaterialPageRoute(builder: (context)=>const LoginScreen());

      case AppRoutes.createRequestScreen:
        return MaterialPageRoute(builder: (context)=>const CreateRequestScreen());
    case AppRoutes.requestDetailsScreen:
    if (routeSettings.arguments is CustomerRequestModel) {
      final customerRequestModel = routeSettings
          .arguments as CustomerRequestModel;
      return MaterialPageRoute(
        builder: (context) =>
            RequestDetailsScreen(requestModel: customerRequestModel),
      );
    }
      case AppRoutes.allRequestsScreen:
        return MaterialPageRoute(builder: (context)=>const AllRequestsScreen());
    }

  }
}