import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/constants/text_data.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/dummy/dummy_data.dart';
import 'package:cabswalle/modules/home/bloc/home_bloc.dart';
import 'package:cabswalle/modules/home/bloc/home_event.dart';
import 'package:cabswalle/modules/home/bloc/home_state.dart';
import 'package:cabswalle/modules/home/screen/widgets/leads_count_show.dart';
import 'package:cabswalle/modules/home/screen/widgets/to_from_dots.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/login_status_service.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/lead_card.dart';
import 'package:cabswalle/widgets/show_image.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchHomeDataEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial || state is HomeLoadingState) {
            return CentreLoading();
          }
          if (state is HomeLoadedState) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubmitButton(
                          onTap: () {
                            context.pushNamed(Names.myleads);
                          },
                          lable: AppLocalizations.of(context)!.myLeads,
                          height: 46,
                          width: context.screenWidth * 0.45,
                          icon: SvgPicture.asset(
                            Assets.iconsMyleads,
                            height: 20,
                          ),
                          borderRadius: 5,
                        ),
                        SubmitButton(
                          onTap: () {
                            context.pushNamed(Names.addlead);
                          },
                          lable: AppLocalizations.of(context)!.addLeads,
                          height: 46,
                          width: context.screenWidth * 0.45,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                          borderRadius: 5,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "${AppLocalizations.of(context)!.pick} ${AppLocalizations.of(context)!.location}",
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.myprimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.myBlack45),
                      ),
                      child: Row(
                        children: [
                          toFromDots(),
                          Expanded(
                            // flex: 5,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText:
                                      AppLocalizations.of(context)!.enterPickup,
                                  hintStyle: AppTextStyles.style15w500(
                                      color: AppColors.myBlack45),
                                  border: InputBorder.none),
                              onChanged: (value) async {
                                if (value.isEmpty) {
                                } else {}
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubmitButton(
                          onTap: () {
                            if (LoginManager.isLogin) {
                              context.pushNamed(Names.cityPreferences);
                            } else {
                              context.pushNamed(Names.login);
                            }
                          },
                          lable: "5 Locations Alerts",
                          height: 42,
                          labelsize: 15,
                          width: context.screenWidth * 0.45,
                          borderRadius: 2,
                        ),
                        SubmitButton(
                          onTap: () {
                            context.pushNamed(Names.filterleads);
                          },
                          lable: "Your Location Duties",
                          labelsize: 15,
                          height: 42,
                          width: context.screenWidth * 0.45,
                          borderRadius: 2,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const ShowLeadCounts(
                      todaysLeadCount: 3472,
                      weeksLeadCount: 22645,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DottedBorder(
                      color: AppColors.myprimaryColor,
                      dashPattern: const [4],
                      strokeWidth: 2,
                      borderType: BorderType.RRect,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: SizedBox(
                          height: 40,
                          width: context.screenWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Start Membership",
                                style: AppTextStyles.style16w500(),
                              ),
                              SubmitButton(
                                onTap: () {},
                                lable: "Recharge Now",
                                height: 28,
                                width: 140,
                                labelsize: 15,
                                borderRadius: 4,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (int i = 0;
                            i <
                                (state.userProfile != null
                                    ? state.userProfile!.notificationLocations!
                                        .length
                                    : 0);
                            i++)
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 - 20,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.colorList[i],
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "  ${state.userProfile!.notificationLocations![i].location!}"
                                      .toUpperCase(),
                                  style: AppTextStyles.style18w500(),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                    if (state.userProfile != null &&
                        state.userProfile!.notificationLocations!.isNotEmpty)
                      const SizedBox(
                        height: 17,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          spacing: 8,
                          children: TextData.leadType.map((lead) {
                            return GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.29,
                                  child: ShowImage(
                                      boxFit: BoxFit.contain,
                                      imagelink: TextData.leadTypeData[lead]

                                          // [true ? 'iconfilled' : 'icon'],
                                          ['icon']),
                                ));
                          }).toList(),
                        ),
                      ],
                    ),
                    for (int i = 0; i < 10; i++)
                      LeadsCard(
                        lead: lead,
                      ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
                child: Text(
              (state as HomeErrorState).errorMessage,
              style: AppTextStyles.style14w600(),
            ));
          }
        },
      ),
    );
  }
}
