import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/constants/text_data.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/core/screen_responsive.dart';
import 'package:cabswalle/modules/filterleads/screen/filterleads_view.dart';
import 'package:cabswalle/modules/home/bloc/home_bloc.dart';
import 'package:cabswalle/modules/home/bloc/home_event.dart';
import 'package:cabswalle/modules/home/bloc/home_state.dart';
import 'package:cabswalle/modules/home/screen/widgets/home_shimmer.dart';
import 'package:cabswalle/modules/home/screen/widgets/leads_count_show.dart';
import 'package:cabswalle/modules/home/screen/widgets/membership_widget.dart';
import 'package:cabswalle/modules/home/screen/widgets/to_from_dots.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:cabswalle/services/single_device_login_service.dart';
import 'package:cabswalle/widgets/lead_card.dart';
import 'package:cabswalle/widgets/lead_card_shimmer.dart';
import 'package:cabswalle/widgets/show_image.dart';
import 'package:cabswalle/widgets/submit_button.dart';
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
  TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double threshold = 10.0;
      if (maxScroll - currentScroll <= threshold) {
        if (searchController.text.trim().isEmpty) {
          if (context.read<HomeBloc>().state is HomeLoadedState &&
              !(context.read<HomeBloc>().state as HomeLoadedState)
                  .fetchingMore) {
            LoggerService.logInfo("Fetching More");
            context.read<HomeBloc>().add(FetchMoreLeadsEvent(pageNo: 1));
          }
        }
      }
    });
    checkSession();
  }

  final SingleLoginService singleLoginService = SingleLoginService();

  void checkSession() async {
    LoggerService.logInfo("Check Session Called");
    bool isSessionMatched = await singleLoginService.verifySession();
    if (!isSessionMatched && LoginManager.isLogin) {
      showModalBottomSheet<void>(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: context.screenHeight * 0.6,
              width: context.screenWidth,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.iconsWarning,
                    height: 100,
                  ),
                  ElevatedButton(
                    child: const Text('Close BottomSheet'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial || state is HomeLoadingState) {
            return HomeShimmer();
          }
          if (state is HomeLoadedState) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(FetchHomeDataEvent());
              },
              child: SafeArea(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 14, right: 14, top: 4),
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.scrollToRefresh,
                                  style: AppTextStyles.style14w600(
                                      color: AppColors.myBlackGrey),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SubmitButton(
                                  onTap: () {
                                    if (LoginManager.isLogin) {
                                      context.pushNamed(Names.myleads);
                                    } else {
                                      context.pushNamed(Names.login);
                                    }
                                  },
                                  lable: AppLocalizations.of(context)!.myLeads,
                                  height: 46,
                                  width: context.screenWidth * 0.445,
                                  icon: SvgPicture.asset(
                                    Assets.iconsMyleads,
                                    height: 20,
                                  ),
                                  borderRadius: 5,
                                ),
                                SubmitButton(
                                  onTap: () {
                                    if (LoginManager.isLogin) {
                                      context.pushNamed(Names.location);
                                    } else {
                                      context.pushNamed(Names.login);
                                    }
                                  },
                                  lable:
                                      "${AppLocalizations.of(context)!.location}s",
                                  height: 46,
                                  width: context.screenWidth * 0.445,
                                  icon: const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  borderRadius: 5,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  toFromDots(),
                                  Expanded(
                                    // flex: 5,
                                    child: TextFormField(
                                      controller: searchController,
                                      focusNode: focusNode,
                                      decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .enterPickup,
                                          hintStyle: AppTextStyles.style15w500(
                                              color: AppColors.myBlack45),
                                          border: InputBorder.none),
                                      onEditingComplete: () {
                                        FocusScope.of(context).unfocus();
                                        focusNode.unfocus();
                                        context.read<HomeBloc>().add(
                                            SearchLeads(
                                                searcText: searchController.text
                                                    .trim(),
                                                countData: state.countData));
                                      },
                                      onChanged: (value) async {
                                        if (value.isEmpty) {
                                          context.read<HomeBloc>().add(
                                              ChangeLeadType(
                                                  leadType: "commission",
                                                  countData: state.countData));
                                        }
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
                                  labelsize: 13,
                                  width: context.screenWidth * 0.445,
                                  borderRadius: 4,
                                ),
                                SubmitButton(
                                  onTap: () {
                                    if (LoginManager.isLogin) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FilterLeadsScreen(city: ""),
                                          ));
                                    } else {
                                      context.pushNamed(Names.login);
                                    }
                                  },
                                  lable: "Your Location Duties",
                                  labelsize: 13,
                                  height: 42,
                                  width: context.screenWidth * 0.445,
                                  borderRadius: 4,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ShowLeadCounts(
                              todaysLeadCount: state.countData.totalLeads,
                              weeksLeadCount: state.countData.totalSearches,
                            ),
                            if (LoginManager.isLogin &&
                                DriverService.instance.driverModel != null)
                              MembershipWidget(
                                isMembershipActive: DriverService
                                    .instance.driverModel!.membership!.active,
                                endDate: DriverService
                                    .instance.driverModel!.membership!.endDate,
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (LoginManager.isLogin)
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.start,
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  for (int i = 0;
                                      i <
                                          (state.userProfile != null
                                              ? state.userProfile!
                                                  .notificationLocations.length
                                              : 0);
                                      i++)
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FilterLeadsScreen(
                                                      city: state.userProfile!
                                                              .notificationLocations[
                                                          i]!),
                                            ));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                    0.5 -
                                                20,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: AppColors.colorList[i],
                                            border:
                                                Border.all(color: Colors.blue),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Center(
                                          child: Text(
                                            "  ${state.userProfile!.notificationLocations[i]!}"
                                                .toUpperCase(),
                                            style: AppTextStyles.style18w500(),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            if (state.userProfile != null &&
                                state.userProfile!.notificationLocations
                                    .isNotEmpty)
                              const SizedBox(
                                height: 8,
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Wrap(
                                  spacing: 8,
                                  children: TextData.leadType.map((lead) {
                                    return GestureDetector(
                                        onTap: () {
                                          context.read<HomeBloc>().add(
                                              ChangeLeadType(
                                                  leadType: lead,
                                                  countData: state.countData));
                                        },
                                        child: SizedBox(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.29,
                                          child: ShowImage(
                                              boxFit: BoxFit.contain,
                                              imagelink: lead == state.leadType
                                                  ? TextData.leadTypeData[lead]
                                                      ['iconfilled']
                                                  : TextData.leadTypeData[lead]
                                                      ["icon"]),
                                        ));
                                  }).toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (state.searchText.isNotEmpty)
                      SliverToBoxAdapter(
                          child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          bottom: 8,
                        ),
                        child: Text(
                          "Pickup From : ${state.searchText}",
                          style: AppTextStyles.style16w500(),
                        ),
                      )),
                    if (!state.leadLoading)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              child: LeadsCard(
                                lead: state.leads.leads[index],
                              ),
                            );
                          },
                          childCount: state.leads.leads.length,
                        ),
                      ),
                    if (state.fetchingMore)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                child: LeadsCardShimmer());
                          },
                          childCount: 1,
                        ),
                      ),
                    if (state.leadLoading)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                child: LeadsCardShimmer());
                          },
                          childCount: 4,
                        ),
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
              ),
            );
          }
        },
      ),
    );
  }
}
