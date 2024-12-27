import 'package:cabswalle/modules/topLocations/topRoutes/bloc/top_routes_bloc.dart';
import 'package:cabswalle/modules/topLocations/topRoutes/bloc/top_routes_event.dart';
import 'package:cabswalle/modules/topLocations/topRoutes/bloc/top_routes_state.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRoutesScreen extends StatefulWidget {
  const TopRoutesScreen({super.key});

  @override
  State<TopRoutesScreen> createState() => _TopRoutesScreenState();
}

class _TopRoutesScreenState extends State<TopRoutesScreen> {
  int selectedTab = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    context
        .read<TopRoutesBloc>()
        .add(FetchRoutes(0, _getCollectionName(), true));
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
      if (context.read<TopRoutesBloc>().state is TopRoutesLoaded &&
          !(context.read<TopRoutesBloc>().state as TopRoutesLoaded)
              .isMoreLoading) {
        context.read<TopRoutesBloc>().add(LoadMoreRoutes());
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
          "Top Routes",
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
              context
                  .read<TopRoutesBloc>()
                  .add(FetchRoutes(0, _getCollectionName(), true));
            },
          ),
        ),
      ),
      body: BlocBuilder<TopRoutesBloc, TopRoutesState>(
        builder: (context, state) {
          if (state is TopRoutesLoaded) {
            return SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
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
                                        "Routes",
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
                            for (int i = 0; i < state.routes.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.blue)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${i + 1}.  ",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Expanded(
                                        child: Text(
                                          state.routes[i].from,
                                          style: const TextStyle(fontSize: 18),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          state.routes[i].to,
                                          style: const TextStyle(fontSize: 18),
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
                            ...state.routes.map((e) => Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, top: 4),
                                    child: Text(
                                      e.count.toString(),
                                      style: const TextStyle(fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
          } else if (state is TopRoutesLoading) {
            return CentreLoading();
          } else {
            return Center(
              child: Text("Something Went Wrong!"),
            );
          }
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
