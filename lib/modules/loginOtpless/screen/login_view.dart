import 'dart:io';
import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/modules/loginOtpless/data/login_data_pepository.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/loading_overlay_service.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/my_text_form_field.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreenOtpless extends StatefulWidget {
  const LoginScreenOtpless({super.key});

  @override
  State<LoginScreenOtpless> createState() => _LoginScreenOtplessState();
}

class _LoginScreenOtplessState extends State<LoginScreenOtpless> {
  final TextEditingController _phoneNoController = TextEditingController();
  final _otplessRepository = OtplessRepository();
  LoginManager loginManager = LoginManager();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSms = false;

  void onHeadlessResult(dynamic result) {
    if (result['statusCode'] == 200) {
      LoadingOverlay().hide();
      switch (result['responseType'] as String) {
        case 'INITIATE':
          {
            context.goNamed(Names.otpOtpless, extra: {
              "phoneNo": _phoneNoController.text.trim(),
              "isSms": isSms
            });
          }
          break;

        case 'OTP_AUTO_READ':
          {
            if (Platform.isAndroid) {
              var otp = result['response']['otp'] as String;
              LoggerService.logInfo("Otp res $otp");
            }
          }

        default:
          {
            SnackbarUtils.showErrorSnackBar(message: "Something Went Wrong!");
          }
          break;
      }
    } else {
      LoadingOverlay().hide();
      SnackbarUtils.showErrorSnackBar(message: "Something Went Wrong!");
    }
  }

  @override
  void initState() {
    super.initState();
    _otplessRepository.setHeadlessCallback(onHeadlessResult);
  }

  void sendLoginRequest({required bool isSms}) {
    final phoneNo = _phoneNoController.text.trim();
    LoadingOverlay().show(context);
    loginManager.setActive("+91$phoneNo");
    _otplessRepository.sendOtp(
        phoneNo: phoneNo,
        onHeadlessResult: onHeadlessResult,
        context: context,
        isSms: isSms);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.screenWidth,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: context.screenHeight * 0.08,
              ),
              headerContainer(
                  context, MediaQuery.of(context).size.height * 0.45),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: MyTextFormField(
                  textEditingController: _phoneNoController,
                  label: AppLocalizations.of(context)!.enterphoneNo,
                  keyboardType: TextInputType.phone,
                  prefixicon: Container(
                    padding: const EdgeInsets.only(top: 2),
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      '+91',
                      style: TextStyle(
                          color: AppColors.myBlack, fontSize: 16, height: 0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterphoneNo;
                    } else if (value.length != 10) {
                      return AppLocalizations.of(context)!.invalidPhoneNo;
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SubmitButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      sendLoginRequest(isSms: false);
                    }
                  },
                  borderRadius: 5,
                  isAtBottom: true,
                  icon: SvgPicture.asset(
                    Assets.iconsWhatsapp,
                    height: 23,
                  ),
                  lable: "${AppLocalizations.of(context)!.login} Via WhatsApp"),
              Text("or"),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      isSms = true;
                      sendLoginRequest(isSms: true);
                    }
                  },
                  child: Text(
                    "Login Via SMS",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.myprimaryColor,
                        decorationStyle: TextDecorationStyle.solid,
                        color: AppColors.myprimaryColor,
                        fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Container headerContainer(BuildContext context, height) {
  var size = MediaQuery.of(context).size;
  return Container(
    alignment: Alignment.bottomCenter,
    height: height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: size.height * 0.3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size.height * 0.3),
            child: Image.asset(
              Assets.imagesAppLogo,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text('CABSWALE',
            style: TextStyle(
                color: AppColors.myprimaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
