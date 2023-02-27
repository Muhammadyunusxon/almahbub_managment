import 'package:almahbub_managment/controller/location_map_controller.dart';
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
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('uz', 'UZ')],
      fallbackLocale: const Locale('uz', 'UZ'),
      startLocale: const Locale('uz', 'UZ'),
      path: 'assets/tr',
      child: const MyApp()));
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
        ChangeNotifierProvider(create: (context) => ChatController()),
        ChangeNotifierProvider(create: (context) => LocationMapController())
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return RefreshConfiguration(
              headerBuilder: () => const MaterialClassicHeader(
                  backgroundColor: kWhiteColor, color: kBrandColor),
              child: MaterialApp(

                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                title: 'Al Managment',
                theme: ThemeData(
                  // useMaterial3: true,
                  primaryColor: kGreenColor,
                ),
                debugShowCheckedModeBanner: false,
                home: const SplashPage(),
              ),
            );
          }),
    );
  }
}
