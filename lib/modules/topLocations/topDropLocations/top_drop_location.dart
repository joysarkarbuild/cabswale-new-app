import 'package:cabswalle/modules/topLocations/topPickupLocation/bloc/top_pickup_location_bloc.dart';
import 'package:cabswalle/modules/topLocations/topPickupLocation/bloc/top_pickup_location_event.dart';
import 'package:cabswalle/modules/topLocations/topPickupLocation/bloc/top_pickup_location_state.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopDropLocationScreen extends StatefulWidget {
  const TopDropLocationScreen({super.key});

  @override
  State<TopDropLocationScreen> createState() => _TopDropLocationScreenState();
}

class _TopDropLocationScreenState extends State<TopDropLocationScreen> {
  int selectedTab = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    context
        .read<TopPickupLocationBloc>()
        .add(FetchTopPickupLocation(0, _getCollectionName(), true, true));
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (context.read<TopPickupLocationBloc>().state
              is TopPickupLocationLoaded &&
          !(context.read<TopPickupLocationBloc>().state
                  as TopPickupLocationLoaded)
              .isMoreLoading) {
        context
            .read<TopPickupLocationBloc>()
            .add(LoadMorePickupLocations(true));
      }
    }
  }

  String _getCollectionName() {
    switch (selectedTab) {
      case 1:
        return 'weeklyPagination';
      case 2:
        return 'dailyPagination';
      default:
        return 'monthlyPagination';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Top Drop Locations",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: TabSelection(
            selectedTab: selectedTab,
            onTabSelected: (index) {
              setState(() {
                selectedTab = index;
              });
              context.read<TopPickupLocationBloc>().add(
                    ResetTopPickupLocation(_getCollectionName(), true),
                  );
            },
          ),
        ),
      ),
      body: BlocBuilder<TopPickupLocationBloc, TopPickupLocationState>(
        builder: (context, state) {
          if (state is TopPickupLocationLoading) {
            return CentreLoading();
          }
          if (state is TopPickupLocationLoaded) {
            return SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "Location",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        height: 1,
                                        width: 100,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            for (int i = 0;
                                i < state.topPickupLocations.length;
                                i++)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.07),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${i + 1}.   ${state.topPickupLocations[i].name}",
                                        style: const TextStyle(fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              "Duties",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Container(
                              height: 1,
                              width: 100,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 10),
                            ...state.topPickupLocations.map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    e.count.toString(),
                                    style: const TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          if (state is TopPickupLocationError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Center(child: Text("Something went wrong!"));
        },
      ),
    );
  }
}

class TabSelection extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabSelected;

  const TabSelection({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTab(context, "30 Days", 0),
          _buildTab(context, "7 Days", 1),
          _buildTab(context, "Today", 2),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String text, int index) {
    return InkWell(
      onTap: () => onTabSelected(index),
      child: Container(
        height: 30,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.blue),
          color: selectedTab == index
              ? Colors.blue.withValues(alpha: 0.3)
              : Colors.transparent,
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
