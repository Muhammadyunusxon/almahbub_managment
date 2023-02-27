import 'package:almahbub_managment/controller/app_controller.dart';
import 'package:almahbub_managment/controller/home_controller.dart';
import 'package:almahbub_managment/view/pages/auth/widgets/splash_body.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../../../controller/local_store/local_store.dart';
import '../../../domen/model/banner_model.dart';
import '../../../domen/model/category_model.dart';
import '../../../domen/model/product_model.dart';
import '../general_connection_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int internetChanged = 0;

  @override
  void initState() {
    FlutterNativeSplash.remove();
    checking();
    super.initState();
  }

  checking() async {
    // ignore: use_build_context_synchronously
    InternetConnectionChecker().onStatusChange.listen((status) async {
      debugPrint(status.toString());
      switch (status) {
        case InternetConnectionStatus.connected:
          if (internetChanged == 1) {
            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Internet is back ',
                message: 'Great, your internet connection is restored.',
                contentType: ContentType.success,
              ),
            );

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
            setState(() {
              internetChanged = 0;
            });
          }
          goNavigator();
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            internetChanged++;
          });

          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'No Internet Connection',
              message: 'Please check your internet.',
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);

          // redirectWhenInternetNotAvailable();

          break;
      }
    });
  }

  goNavigator() async {
    String? docId = await LocalStore.getDocId();
    if (docId != null) {
      // ignore: use_build_context_synchronously
      context.read<HomeController>()
        ..getBanners()
        ..getProduct();
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const GeneralPage()),
          (route) => false);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashBody(isOnline: null);
  }
}
