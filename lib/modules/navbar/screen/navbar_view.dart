import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/modules/community/screen/community_view.dart';
import 'package:cabswalle/modules/deals/screen/deals_view.dart';
import 'package:cabswalle/modules/home/screen/home_view.dart';
import 'package:cabswalle/modules/location/screen/location_view.dart';
import 'package:cabswalle/modules/navbar/bloc/navbar_bloc.dart';
import 'package:cabswalle/modules/navbar/bloc/navbar_event.dart';
import 'package:cabswalle/modules/navbar/bloc/navbar_state.dart';
import 'package:cabswalle/modules/profile/screen/profile_view.dart';
import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/login_status_service.dart';
import 'package:cabswalle/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class NavbarScreen extends StatelessWidget {
  NavbarScreen({super.key});

  final List<Widget> tabs = [
    const HomeScreen(),
    const LocationScreen(),
    const CommunityScreen(),
    const DealsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: tabs[state.selectedIndex],
          bottomNavigationBar: MyBottomNavBar(
            labelStyle: const TextStyle(fontSize: 10),
            elevation: 1,
            currentIndex: state.selectedIndex,
            showIndicator: false,
            onTap: (index) {
              if (index > 0 && !LoginManager.isLogin) {
                context.goNamed(Names.login);
                LoginManager().clearLoginStatus();
                return;
              }
              context.read<NavbarBloc>().add(ChangeTab(index));
            },
            bottomNavBarItems: <Map<String, dynamic>>[
              {'icon': Assets.iconsHome, 'label': 'Home'},
              {'icon': Assets.iconsLocation, 'label': 'Locations'},
              {
                'icon': Assets.iconsCommunity,
                'label': 'Community',
                "showLabel": false,
                "iconSize": 40.0,
              },
              {
                'icon': Assets.iconsDeal,
                'label': 'Deals',
              },
              {
                'icon': Assets.iconsProfile,
                'label': 'Profile',
                "iconSize": 18.0
              },
            ].map((item) {
              return BottomNavBarItem(
                iconSize: item["iconSize"] ?? 20,
                showLabel: item["showLabel"] ?? true,
                icon: SvgPicture.asset(
                  item['icon']!.toString(),
                  height: 20,
                ),
                activeIcon: SvgPicture.asset(
                  item['icon']!.toString(),
                  height: 20,
                  colorFilter: item['icon']!.toString().contains("community")
                      ? null
                      : const ColorFilter.mode(
                          AppColors.myprimaryColor,
                          BlendMode.srcIn,
                        ),
                ),
                label: item['label'].toString(),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
