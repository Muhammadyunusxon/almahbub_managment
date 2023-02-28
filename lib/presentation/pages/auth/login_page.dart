import 'package:almahbub_managment/presentation/pages/auth/widgets/password_field.dart';
import 'package:almahbub_managment/presentation/pages/auth/widgets/phone_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../application/auth_controller.dart';
import '../../utils/Style/style.dart';
import '../../utils/component/my_button.dart';
import '../../utils/constants.dart';
import '../general_connection_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  @override
  void initState() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 90),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "AL MAHBUB",
                  style: Style.brandStyle(textColor: kYellowColor, size: 32),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "admin_program".tr(),
                  style:
                      Style.textStyleNormal(textColor: kWhiteColor, size: 24),
                ),
              ),
              const SizedBox(height: 38),
              Container(
                height: 376,
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: kWhiteColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PhoneField(phoneController: phoneController),
                    PasswordField(passwordController: passwordController),
                    const Spacer(),
                    context.watch<AuthController>().errorText != null
                        ? Text(
                            context.watch<AuthController>().errorText ?? "",
                            style: Style.textStyleNormal(
                                size: 14, textColor: Style.redColor),
                          )
                        : const SizedBox.shrink(),
                    const Spacer(),
                    MyButton(
                        title: "sign_in".tr(),
                        isActive: phoneController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty,
                        onTap: () {
                          context.read<AuthController>().login(
                              phoneController.text, passwordController.text,
                              () {
                            phoneController.clear();
                            passwordController.clear();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const GeneralPage()),
                                (route) => false);
                          });
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
