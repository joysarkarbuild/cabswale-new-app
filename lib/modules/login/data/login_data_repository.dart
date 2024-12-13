import 'package:cabswalle/modules/login/bloc/login_bloc.dart';
import 'package:cabswalle/modules/login/bloc/login_event.dart';
import 'package:cabswalle/modules/otp/screen/otp_view.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/login_manager.dart';

class LoginDataRepository {
  final LoginManager loginManager = LoginManager();
  Future<String> onSubmit(
      BuildContext context, String phoneNoWithout, bool isResend) async {
    context.read<LoginBloc>().add(StartVerificationEvent());
    String phoneNo = "+91$phoneNoWithout";

    bool isBlocked = await loginManager.isBlock(phoneNo);

    if (isBlocked) {
      showMyDialoge(
        // ignore: use_build_context_synchronously
        context: context,
        no: 'Ok',
        yes: "Call Now",
        onYes: () {
          launchUrl(Uri.parse("tel:+919403890306"));
        },
        content: const Text(
            'You have been blocked by the admin. Please contact the admin to resolve this issue.'),
      );
    } else {
      await loginManager.setActive(phoneNo);

      // ignore: use_build_context_synchronously
      context.read<LoginBloc>().add(LoginClickEvent(
            // ignore: use_build_context_synchronously
            context: context,
            onCodeSent: (verificationId) {
              if (isResend) {
                SnackbarUtils.showSuccessSnackBar(
                    message: "OTP sent successfully!");
                return verificationId;
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpScreen(
                      phoneNo: phoneNoWithout,
                      verificationId: verificationId,
                    ),
                  ),
                );
              }
            },
            onError: (e) {
              String errorMessage = "An unknown error occurred.";
              switch (e.code) {
                case 'invalid-phone-number':
                  errorMessage = "The phone number entered is invalid.";
                  break;
                case 'too-many-requests':
                  errorMessage = "Too many requests. Please try again later.";
                  break;
                case 'network-request-failed':
                  errorMessage = "Network error. Please check your connection.";
                  break;
                default:
                  errorMessage = e.message ?? "An unknown error occurred.";
              }
              showMyDialoge(
                context: context,
                no: '/null',
                yes: "Ok",
                onYes: () {
                  Navigator.pop(context);
                },
                content: Text(errorMessage),
              );
            },

            phoneNo: phoneNo,
          ));
    }

    return "";
  }
}
