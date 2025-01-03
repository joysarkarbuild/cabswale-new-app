import 'package:cabswalle/constants/text_data.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/language/bloc/language_bloc.dart';
import 'package:cabswalle/modules/language/bloc/language_event.dart';
import 'package:cabswalle/modules/language/bloc/language_state.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cabswalle/widgets/my_listtile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: AppLocalizations.of(context)!.changeLanguage,
        centerTitle: true,
      ),
      body: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: TextData.languageList.length,
                itemBuilder: (ctx, index) {
                  bool isSelected = (state as LanguageInitial).local ==
                      TextData.languageList[index]["code"];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyListTile(
                      onTap: () {
                        context.read<LanguageBloc>().add(ChangeLanguageEvent(
                            local: TextData.languageList[index]["code"]));
                      },
                      borderColor: isSelected
                          ? AppColors.myprimaryColor
                          : AppColors.myGrey,
                      borderRadius: BorderRadius.circular(12),
                      title: TextData.languageList[index]['style'],
                      titleStyle: AppTextStyles.style18w600(),
                      subtitle: Text(
                        TextData.languageList[index]['name'],
                        style: AppTextStyles.style15w600(),
                      ),
                      // leadingHeight: 20,
                      leadingColor: AppColors.myTranspsarent,
                      leadingchild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isSelected
                              ? const Icon(
                                  CupertinoIcons.largecircle_fill_circle,
                                  color: AppColors.myprimaryColor,
                                )
                              : const Icon(CupertinoIcons.circle),
                        ],
                      ),
                      // trailing: Image.asset(dummyLang[index]['icon'])
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
