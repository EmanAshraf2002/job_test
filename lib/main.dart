import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_test/core/routes/app_routes.dart';
import 'package:job_test/core/routes/router.dart';
import 'package:job_test/core/utills/app_colors.dart';
import 'package:job_test/providers/auth_provider.dart';
import 'package:job_test/providers/requests_provider.dart';
import 'package:provider/provider.dart';

import 'core/cachehelper/cache_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> AuthProvider()),
        ChangeNotifierProvider(create: (context)=> RequestsProvider()),
        // Add more providers here if needed
      ],
      child: ScreenUtilInit(
        designSize:const Size(375, 812),
        child: MaterialApp(
        theme: ThemeData(
         primarySwatch: Colors.red,
        ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialScreen,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}