import 'package:almahbub_managment/controller/auth_controller.dart';
import 'package:almahbub_managment/controller/home_controller.dart';
import 'package:almahbub_managment/controller/product_controller.dart';
import 'package:almahbub_managment/view/pages/auth/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>AuthController()),
        ChangeNotifierProvider(create: (context)=>HomeController()),
        ChangeNotifierProvider(create: (context)=>ProductController())
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
        builder: (context,child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          );
        }
      ),
    );
  }
}
