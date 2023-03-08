import 'package:almahbub_managment/presentation/routes/app_router.gr.dart';
import 'package:almahbub_managment/presentation/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../application/app_controller.dart';
import '../application/auth_controller.dart';
import '../application/chat_controller.dart';
import '../application/home_controller.dart';
import '../application/location_map_controller.dart';
import '../application/product_controller.dart';

class AppWidget extends StatelessWidget {
  final _appRouter = AppRouter();

  AppWidget({super.key});

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
              child: MaterialApp.router(
                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                title: 'Al Managment',
                theme: ThemeData(
                  useMaterial3: true,
                  primaryColor: kGreenColor,
                ),
                debugShowCheckedModeBanner: false,
                routerDelegate: _appRouter.delegate(),
                routeInformationParser: _appRouter.defaultRouteParser(),
              ),
            );
          }),
    );
  }
}
