/*
collection on some widget components
*/

import 'dart:io';
import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/widgets/show_image.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

PreferredSize myAppBar(
    {required context,
    required String title,
    String? subtitle,
    leading = true,
    bool centerTitle = false,
    trailing,
    buttoncolor = Colors.white,
    void Function()? onBackButton,
    Color backgroundColor = Colors.white,
    Color forgroundColor = Colors.black,
    double elevation = 0}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(50),
    child: AppBar(
      backgroundColor: backgroundColor,
      leadingWidth: leading ? null : 1,
      leading: leading
          ? IconButton(
              onPressed: onBackButton ??
                  () {
                    Navigator.pop(context);
                  },
              icon: Icon(
                CupertinoIcons.arrow_left,
                color: forgroundColor,
              ))
          : null,
      elevation: elevation,
      actions: [
        Container(
          child: trailing,
        )
      ],
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title),
        if (subtitle != null)
          const SizedBox(
            height: 7,
          ),
        if (subtitle != null)
          Text(
            subtitle,
            style: TextStyle(
                color: forgroundColor.withValues(alpha: 0.8), fontSize: 15),
          )
      ]),
      centerTitle: centerTitle,
      titleTextStyle: TextStyle(
          fontFamily: 'Urbanist',
          color: forgroundColor,
          fontSize: 18,
          fontWeight: FontWeight.w500),
    ),
  );
}

Widget textOnDivider(
  context, {
  required String text,
  double intend = 20,
  double endIntend = 20,
  Color textAndDividerColor = Colors.black,
  double fontsize = 15,
}) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            endIndent: 0.0,
            indent: intend,
            color: textAndDividerColor,
            height: 20,
          ),
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textAndDividerColor,
                      fontSize: fontsize,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            endIndent: endIntend,
            indent: 0.0,
            color: textAndDividerColor,
            height: 20,
          ),
        ),
      ],
    ),
  );
}

Widget myIconButton({
  required dynamic icon,
  color,
  onTap,
  double size = 50,
  double radius = 5,
  double margin = 0,
  borderColor = Colors.transparent,
}) {
  return InkWell(
    splashColor: AppColors.myWhite,
    borderRadius: BorderRadius.circular(radius),
    onTap: onTap,
    child: Container(
      height: size,
      width: size,
      margin: EdgeInsets.all(margin),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: icon,
    ),
  );
}

showMyDialoge({
  required context,
  Widget? title,
  required Widget content,
  yes = 'YES',
  no = 'NO',
  onYes,
}) {
  yes = yes == 'YES' ? AppLocalizations.of(context)!.yes.toUpperCase() : yes;
  no = no == 'NO' ? AppLocalizations.of(context)!.no.toUpperCase() : no;

  return showDialog(
      barrierDismissible: false,
      useSafeArea: false,
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: title ?? const Text('CABSWALE'),
            content: content == const Text('') ? null : content,
            actions: [
              if (no != '/null')
                Expanded(
                    flex: 1,
                    child: no == ''
                        ? Container()
                        : Material(
                            color: Colors.transparent,
                            child: SubmitButton(
                                labelsize: 14,
                                height: 35,
                                color: Colors.transparent,
                                borderColor: Colors.transparent,
                                labelColor: AppColors.myprimaryColor,
                                borderRadius: 4,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                lable: no),
                          )),
              if (no != '/null')
                Material(
                  color: Colors.transparent,
                  child: Expanded(
                      flex: 1,
                      child: yes == ''
                          ? Container()
                          : SubmitButton(
                              color: Colors.transparent,
                              borderColor: Colors.transparent,
                              borderRadius: 4,
                              labelColor: AppColors.myprimaryColor,
                              labelsize: 14,
                              height: 35,
                              onTap: onYes,
                              lable: yes)),
                ),
              if (no == '/null')
                yes == ''
                    ? Container()
                    : Material(
                        color: Colors.transparent,
                        child: SubmitButton(
                            color: Colors.transparent,
                            borderColor: Colors.transparent,
                            labelColor: AppColors.myprimaryColor,
                            labelsize: 14,
                            height: 35,
                            width: 150,
                            onTap: onYes,
                            borderRadius: 4,
                            lable: yes),
                      )
              // if (no != '')
              //   Material(
              //     color: Colors.transparent,
              //     child: SubmitButton(
              //         color: Colors.transparent,
              //         borderColor: Colors.transparent,
              //         labelColor: myprimaryColor,
              //         onTap: () {
              //           Navigator.pop(context);
              //         },
              //         lable: no),
              //   ),
              // if (yes != '')
              //   Material(
              //     color: Colors.transparent,
              //     child: SubmitButton(
              //         color: Colors.transparent,
              //         borderColor: Colors.transparent,
              //         labelColor: myprimaryColor,
              //         onTap: onYes,
              //         lable: yes),
              // ),
            ],
          );
        } else {
          return AlertDialog(
            alignment: Alignment.center,
            titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            title: title ??
                const Align(
                  alignment: Alignment.topLeft,
                  child: AppLogo(height: 40),
                ),
            content: content == const Text('') ? null : content,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (no != '/null')
                    Expanded(
                        flex: 1,
                        child: no == ''
                            ? Container()
                            : SubmitButton(
                                labelsize: 14,
                                height: 35,
                                color: Colors.transparent,
                                labelColor: AppColors.myprimaryColor,
                                borderRadius: 4,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                lable: no)),
                  if (no != '/null')
                    Expanded(
                        flex: 1,
                        child: yes == ''
                            ? Container()
                            : SubmitButton(
                                labelsize: 14,
                                height: 35,
                                onTap: onYes,
                                borderRadius: 4,
                                lable: yes)),
                  if (no == '/null')
                    yes == ''
                        ? Container()
                        : SubmitButton(
                            labelsize: 14,
                            height: 35,
                            width: 150,
                            borderRadius: 4,
                            onTap: onYes,
                            lable: yes)
                ],
              )
            ],
          );
        }
      });
}

mySnackBar(context, message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.antiAlias,
      duration: const Duration(seconds: 1),
      backgroundColor: AppColors.myprimaryColor.withValues(alpha: 0.8),
      content: Text(message)));
}

loadingSnacbar(context) {
  return showDialog(
    barrierDismissible: false,
    useSafeArea: false,
    context: context,
    builder: (ctx) {
      return Center(
        child: Container(
            // height: 70,
            // width: 70,
            decoration: const BoxDecoration(
                color: AppColors.myWhite, shape: BoxShape.circle),
            padding: const EdgeInsets.all(10),
            child: const CircularProgressIndicator()),
      );
    },
  );
}

RichText priceAndDpriceRichText(
    {required price,
    required discountPrice,
    textsize = 14,
    Color priceColor = Colors.black,
    Color? dicountProcColor}) {
  return RichText(
      text: TextSpan(
          text: discountPrice == 0.0 ? '₹ $price  ' : '₹ $discountPrice  ',
          style: TextStyle(
              color: dicountProcColor ?? priceColor,
              fontSize: double.parse('$textsize'),
              fontWeight: FontWeight.w500),
          children: [
        TextSpan(
            text: discountPrice == 0.0 ? '   ' : '₹ $price',
            style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: priceColor,
                fontWeight: FontWeight.w400))
      ]));
}

InkWell accountTile({title, icon, onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          SizedBox(
            height: 23,
            width: 23,
            child: ShowImage(
              imagelink: icon,
              boxFit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(title),
          const Spacer(),
          const Icon(CupertinoIcons.right_chevron)
        ],
      ),
    ),
  );
}

String myImage({
  required Map imageMap,
  firstPrf = 'mob',
  secPrf = 'thumb',
  thirdPrf = 'org',
  myplaceholder =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png',
}) {
  if (imageMap.isEmpty || imageMap.runtimeType == String) {
    return myplaceholder;
  } else if (imageMap.toString().contains(firstPrf)) {
    //print('returning $firstPrf');
    return imageMap[firstPrf];
  } else if (imageMap.toString().contains(secPrf)) {
    //print('returning $secPrf');
    return imageMap[secPrf];
  } else if (imageMap.toString().contains(thirdPrf)) {
    //print('returning $thirdPrf');
    return imageMap[thirdPrf];
  } else {
    return myplaceholder;
  }
}

void myCommonBottomSheet(
    {context,
    required String title,
    Widget? icon,
    String? subtitle,
    void Function()? onTap,
    String buttonLabel = 'Done'}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.myTranspsarent,
      builder: (ctx) {
        return Container(
          color: AppColors.myTranspsarent,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    // color: myWhite.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColors.myWhite,
                          blurRadius: 20,
                          spreadRadius: 5)
                    ]),
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.style20w500(),
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.style15w500(),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    SubmitButton(onTap: onTap ?? () {}, lable: buttonLabel)
                  ],
                ),
              ),
              Positioned(
                  child: Container(
                height: 80,
                alignment: Alignment.center,
                child: icon,
              ))
            ],
          ),
        );
      });
}

/// This is the logo of app
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.height = 50,
    this.textheight = 0,
    this.showText = true,
  });
  final double height;
  final double textheight;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: height,
              width: height,
              child: const ShowImage(
                imagelink: Assets.imagesCabIcon,
                boxFit: BoxFit.contain,
              ),
            ),
            if (showText)
              const SizedBox(
                width: 7,
              ),
            if (showText)
              Text(
                'CABSWALE',
                style: TextStyle(
                    fontSize: textheight == 0 ? height / 2.2 : textheight,
                    fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

showWarningDialoge({
  required context,
  Widget? title,
  required Widget content,
  yes = 'YES',
  no = 'NO',
  onYes,
}) {
  yes = yes == 'YES' ? AppLocalizations.of(context)!.yes.toUpperCase() : yes;
  no = no == 'NO' ? AppLocalizations.of(context)!.no.toUpperCase() : no;

  return showDialog(
      barrierDismissible: false,
      useSafeArea: false,
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('WARNING')]),
            content: content == const Text('') ? null : content,
            actions: [
              if (no != '')
                Material(
                  color: Colors.transparent,
                  child: SubmitButton(
                      color: Colors.transparent,
                      borderColor: Colors.transparent,
                      labelColor: AppColors.myprimaryColor,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      lable: no),
                ),
              if (yes != '')
                Material(
                  color: Colors.transparent,
                  child: SubmitButton(
                      color: Colors.transparent,
                      borderColor: Colors.transparent,
                      labelColor: AppColors.myprimaryColor,
                      onTap: onYes,
                      lable: yes),
                ),
            ],
          );
        } else {
          return AlertDialog(
            alignment: Alignment.center,
            titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            title: title ??
                const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('WARNING')]),
            content: content == const Text('') ? null : content,
            actions: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: no == ''
                          ? Container()
                          : SubmitButton(
                              labelsize: 14,
                              height: 35,
                              color: Colors.transparent,
                              labelColor: AppColors.myprimaryColor,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              lable: no)),
                  Expanded(
                      flex: 1,
                      child: yes == ''
                          ? Container()
                          : SubmitButton(
                              labelsize: 14,
                              height: 35,
                              onTap: onYes,
                              lable: yes)),
                ],
              )
            ],
          );
        }
      });
}
