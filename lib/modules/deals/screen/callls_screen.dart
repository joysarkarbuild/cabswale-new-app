import 'dart:async';

import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/services/calls_service.dart';
import 'package:cabswalle/widgets/calls_card.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CallHistoryScreen extends StatefulWidget {
  const CallHistoryScreen({super.key});
  static const route = 'call_history_screen';

  @override
  State<CallHistoryScreen> createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  final CallsService _callsService = CallsService();
  late Future<Map<String, dynamic>> callStatsFuture;

  Future<Map<String, dynamic>> fetchCallStats() async {
    final driverId = FirebaseAuth.instance.currentUser!.uid;
    final docSnapshot = await FirebaseFirestore.instance
        .collection('drivers')
        .doc(driverId)
        .get();

    return docSnapshot.data() ?? {'incomingCalls': 0, 'outgoingCalls': 0};
  }

  Future<void> _fetchCallHistory({bool refresh = false}) async {
    if (!_callsService.hasMoreData && !refresh) return;

    setState(() {
      _callsService.fetchingMoreLeadsLoader = !refresh;
    });

    await _callsService.getCallHistory(refresh: refresh);

    setState(() {
      _callsService.fetchingMoreLeadsLoader = false;
    });
  }

  @override
  void initState() {
    super.initState();

    // Initialize call stats fetch
    callStatsFuture = fetchCallStats();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCallHistory(refresh: true);
    });

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double threshold = 80.0;

      if (maxScroll - currentScroll <= threshold &&
          !_callsService.fetchingMoreLeadsLoader) {
        _fetchCallHistory();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'Calls',
        leading: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.myGrey)),
              child: FutureBuilder<Map<String, dynamic>>(
                future: callStatsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CentreLoading();
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Failed to load stats.'));
                  }

                  final data = snapshot.data!;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Calls Received',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${data['incomingCalls'] ?? 0}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        thickness: .8,
                        color: AppColors.myGrey,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Calls Done',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${data['outgoingCalls'] ?? 0}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Recent Calls',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: [
                ..._callsService.allCallList.map((call) {
                  return CallsCard(call: call);
                }).toList(),
                if (_callsService.fetchingMoreLeadsLoader)
                  const CallsCardShimmer(), // Show loader only at the end
              ],
            ),
            if (!_callsService.hasMoreData && !_callsService.isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No more calls to load.'),
              ),
          ],
        ),
      ),
    );
  }
}
