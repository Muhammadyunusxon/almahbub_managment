import 'package:almahbub_managment/view/utils/constants.dart';
import 'package:almahbub_managment/controller/app_controller.dart';
import 'package:almahbub_managment/controller/auth_controller.dart';
import 'package:almahbub_managment/controller/chat_controller.dart';
import 'package:almahbub_managment/controller/home_controller.dart';
import 'package:almahbub_managment/controller/product_controller.dart';
import 'package:almahbub_managment/view/pages/auth/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => AppController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => ChatController())
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              theme: ThemeData(
                primaryColor: kGreenColor,
              ),
              debugShowCheckedModeBanner: false,
              home:  const SplashPage(),
            );
          }),
    );
  }
}
