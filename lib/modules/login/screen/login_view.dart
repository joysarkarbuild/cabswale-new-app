import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/widgets/my_text_form_field.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  // textEditingController: _phoneNoController,
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
                    context.push(Routes.otp);
                  },
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
