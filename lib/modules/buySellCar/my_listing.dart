import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/modules/buySellCar/buy_sell_car_screen.dart';
import 'package:cabswalle/modules/buySellCar/data/models/car_model.dart';
import 'package:cabswalle/modules/buySellCar/sell_car_screen.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyListingScreen extends StatefulWidget {
  const MyListingScreen({super.key});

  @override
  State<MyListingScreen> createState() => _MyListingScreenState();
}

class _MyListingScreenState extends State<MyListingScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<CarModel> _jobs = [];
  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchJobs();

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _fetchJobs();
      }
    });
  }

  Future<void> _setActiveStatus(String jobId, int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('carDeals')
          .doc(jobId)
          .update({
        'active': !_jobs[index].active,
      });

      setState(() {
        _jobs[index] = _jobs[index].copyWith(active: !_jobs[index].active);
      });
    } catch (e) {
      // Handle any errors
      // ignore: use_build_context_synchronously
      SnackbarUtils.showErrorSnackBar(
          message: 'Failed to update job status: $e');
    }
  }

  Future<void> _deleteCar(String jobId, int index) async {
    try {
      await FirebaseFirestore.instance
          .collection('carDeals')
          .doc(jobId)
          .delete();
      SnackbarUtils.showSuccessSnackBar(message: 'Job deleted successfully!');

      setState(() {
        _jobs.removeAt(index);
      }); // Refresh the job list after deletion
    } catch (e) {
      // Handle any errors
      // ignore: use_build_context_synchronously
      SnackbarUtils.showErrorSnackBar(message: 'Failed to delete job: $e');
    }
  }

  Future<void> _fetchJobs() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    Query query = FirebaseFirestore.instance
        .collection('carDeals')
        .where('uid',
            isEqualTo: DriverService
                .instance.driverModel!.id!) // Add the condition for UID
        .orderBy('createdAt', descending: true)
        .limit(5);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;

      final List<CarModel> newJobs = snapshot.docs
          .map((doc) => CarModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      setState(() {
        _jobs.addAll(newJobs);
        _hasMore = newJobs.length == 5; // If less than 5, no more jobs to fetch
      });
    } else {
      setState(() {
        _hasMore = false; // No more documents
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Method to refresh the job list
  Future<void> _refreshJobs() async {
    setState(() {
      _jobs.clear();
      _lastDocument = null;
      _hasMore = true;
    });
    await _fetchJobs(); // Fetch the latest jobs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Listings"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshJobs,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SubmitButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCarScreen(
                        isMain: true,
                      ),
                    ),
                  );
                },
                borderRadius: 5,
                lable: "Sell Car",
                icon: const Icon(
                  Icons.add,
                  color: AppColors.myWhite,
                ),
                height: 45,
              ),
            ),
            Expanded(
              child: _jobs.isEmpty
                  ? Center(
                      child: Text(
                        "No data available",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          _jobs.length + (_isLoading || _hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < _jobs.length) {
                          return BuyAndSellCarCard(
                            car: _jobs[index],
                            isMyCar: true,
                            deleteCardDeals: () {
                              _deleteCar(_jobs[index].id, index);
                            },
                            changeActiveStatus: () {
                              _setActiveStatus(_jobs[index].id, index);
                            },
                          );
                        } else if (_isLoading) {
                          return CentreLoading();
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}