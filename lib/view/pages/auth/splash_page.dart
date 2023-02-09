import 'package:almahbub_managment/controller/app_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../controller/local_store/local_store.dart';
import '../../style/style.dart';
import '../general_connection_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getInfo();
    });

    super.initState();
  }

  getInfo() async {
    String? docId = await LocalStore.getDocId();
    bool isOnline = await InternetConnectionChecker().hasConnection;
    // ignore: use_build_context_synchronously
    context.read<AppController>().changeOnline(isOnline);
    if (isOnline) {
      if (docId != null) {
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
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (snapshot.hasData) {
              context.read<AppController>().changeOnline(true);
              getInfo();
            } else if (snapshot.connectionState.name == "waiting") {
              context.read<AppController>().changeOnline(false);
            } else {
              context.read<AppController>().changeOnline(null);
            }
          });
          return Scaffold(
            backgroundColor: kGreenColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (MediaQuery.of(context).size.height / 2.05).verticalSpace,
                Center(
                  child: Text(
                    'AL MAHBUB',
                    style: Style.brandStyleBold(),
                  ),
                ),
                32.verticalSpace,
                context.watch<AppController>().isOnline == true && context.watch<AppController>().isOnline != null
                    ? const SizedBox.shrink()
                    : context.watch<AppController>().isOnline == false &&
                            context.watch<AppController>().isOnline != null
                        ? Center(
                            child: Text(
                              'Internetga ulaning',
                              style: Style.brandStyle(
                                  size: 18, textColor: kYellowColor),
                            ),
                          )
                        : const CircularProgressIndicator(
                            color: kYellowColor,
                          )
              ],
            ),
          );
        });
  }
}
