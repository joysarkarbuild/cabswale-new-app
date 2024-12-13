import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/modules/login/bloc/login_bloc.dart';
import 'package:cabswalle/modules/login/bloc/login_state.dart';
import 'package:cabswalle/modules/login/data/login_data_repository.dart';
import 'package:cabswalle/widgets/my_text_form_field.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginDataRepository loginDataRepository = LoginDataRepository();

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
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return SubmitButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        loginDataRepository.onSubmit(
                            context, _phoneNoController.text.trim(), false);
                      }
                    },
                    loading: (state is LoginLoadingState),
                    borderRadius: 5,
                    isAtBottom: true,
                    lable: AppLocalizations.of(context)!.login,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container headerContainer(BuildContext context, double height) {
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
        const Text(
          'CABSWALE',
          style: TextStyle(
            color: AppColors.myprimaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
