import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/modules/login/data/login_data_pepository.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/loading_overlay_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/my_text_form_field.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNoController = TextEditingController();
  final _otplessRepository = OtplessRepository();

  void onHeadlessResult(dynamic result) {
    if (result['statusCode'] == 200) {
      LoadingOverlay().hide();
      switch (result['responseType'] as String) {
        case 'INITIATE':
          {
            context.goNamed(Names.otp, extra: _phoneNoController.text.trim());
          }
          break;

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

  void sendLoginRequest() {
    final phoneNo = _phoneNoController.text.trim();
    LoadingOverlay().show(context);
    _otplessRepository.sendOtp(
        phoneNo: phoneNo, onHeadlessResult: onHeadlessResult);
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
                child: MyTextFormField(
                  textEditingController: _phoneNoController,
                  label: AppLocalizations.of(context)!.enterphoneNo,
                  keyboardType: TextInputType.phone,
                  prefixicon: Container(
                    padding: const EdgeInsets.only(bottom: 2),
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      '+91',
                      style: TextStyle(color: AppColors.myBlack, fontSize: 15),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter phone No.";
                    } else if (value.length < 10) {
                      return " Please Enter Valid phone No.";
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
                    sendLoginRequest();
                  },
                  borderRadius: 5,
                  isAtBottom: true,
                  lable: AppLocalizations.of(context)!.login)
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
