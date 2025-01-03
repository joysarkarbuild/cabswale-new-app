import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/services/single_device_login_service.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

final SingleLoginService singleLoginService = SingleLoginService();

void checkSession(BuildContext context) async {
  LoggerService.logInfo("Check Session Called");
  bool isSessionMatched = await singleLoginService.verifySession();
  if (!isSessionMatched && LoginManager.isLogin) {
    await Future.delayed(Duration(seconds: 2));
    showModalBottomSheet<void>(
      // ignore: use_build_context_synchronously
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false, // Prevent back button close
          child: Container(
            height: context.screenHeight * 0.6,
            width: context.screenWidth,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                SvgPicture.asset(
                  Assets.iconsWarning,
                  height: 160,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "You can only access one account on one device at a time!",
                  style: AppTextStyles.style18w600(height: 1.4),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                SubmitButton(
                  onTap: () async {
                    await LoginManager().logout();
                    // ignore: use_build_context_synchronously
                    context.goNamed(Names.login);
                  },
                  lable: "Re-Login",
                  borderRadius: 6,
                  height: 46,
                ),
                SizedBox(
                  height: 10,
                ),
                Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
