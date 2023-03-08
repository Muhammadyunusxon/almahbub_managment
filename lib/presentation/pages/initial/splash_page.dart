import 'package:almahbub_managment/presentation/routes/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../infrastructure/service/local_store/local_store.dart';
import '../../utils/Style/style.dart';
import '../../utils/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int internetChanged = 0;

  @override
  void initState() {
    goNavigator();
    FlutterNativeSplash.remove();
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
      context.replaceRoute(const MainRoute());

    } else {
      // ignore: use_build_context_synchronously
      context.replaceRoute(const LoginRoute());
      // Navigator.pushAndRemoveUntil(context,
      //     MaterialPageRoute(builder: (_) => const MainPage()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 10),
          Center(
            child: Text(
              'AL MAHBUB',
              style: Style.brandStyleBold(),
            ),
          ),
          const Spacer(),
          const Spacer(flex: 10),
        ],
      ),
    );
  }
}
