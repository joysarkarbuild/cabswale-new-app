import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/core/app_text_styles.dart';
import 'package:cabswalle/modules/buySellCar/data/models/car_model.dart';
import 'package:cabswalle/modules/buySellCar/edit_sell_car.dart';
import 'package:cabswalle/modules/buySellCar/my_listing.dart';
import 'package:cabswalle/modules/buySellCar/sell_car_screen.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/typesense_service.dart';
import 'package:cabswalle/widgets/carosusel_with_dots.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/search_box.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyAndSellCarScreen extends StatefulWidget {
  const BuyAndSellCarScreen({super.key});

  @override
  State<BuyAndSellCarScreen> createState() => _BuyAndSellCarScreenState();
}

class _BuyAndSellCarScreenState extends State<BuyAndSellCarScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<CarModel> _jobs = [];
  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  bool _hasMore = true;
  bool isFirst = true;

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

  Future<void> _fetchJobs() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    Query query = FirebaseFirestore.instance
        .collection('carDeals')
        .where('isVerified', isEqualTo: true)
        .where('active', isEqualTo: true)
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
      isFirst = false;
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

  TypeSenseInstance typeSenseInstance = TypeSenseInstance();

  void onSearch(String search) async {
    if (search.isEmpty) {
      _refreshJobs();
      return;
    }
    var data = await typeSenseInstance.getSearchCars(search);
    _jobs.clear();
    _jobs.addAll(data);
    setState(() {
      _hasMore = false; // No more documents
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buy/Sell Cars"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshJobs, // Trigger the refresh method
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubmitButton(
                    borderRadius: 5,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyListingScreen(),
                          ));
                    },
                    lable: "My Listings",
                    icon: const Icon(
                      Icons.list,
                      color: AppColors.myWhite,
                    ),
                    height: 42,
                    width: MediaQuery.of(context).size.width * 0.46,
                  ),
                  SubmitButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCarScreen(
                              isMain: false,
                            ),
                          ));
                    },
                    borderRadius: 5,
                    lable: "Sell Car",
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.myWhite,
                    ),
                    height: 42,
                    width: MediaQuery.of(context).size.width * 0.46,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: SearchBox(
                onChanged: onSearch,
              ),
            ),
            Expanded(
              child: (_isLoading && isFirst)
                  ? const CentreLoading()
                  : _jobs.isEmpty
                      ? const Center(
                          child: Text("No car available"),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              _jobs.length + (_isLoading || _hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < _jobs.length) {
                              return BuyAndSellCarCard(
                                car: _jobs[index],
                                isMyCar: false,
                                changeActiveStatus: () {},
                                deleteCardDeals: () {},
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

class BuyAndSellCarCard extends StatelessWidget {
  const BuyAndSellCarCard(
      {super.key,
      required this.car,
      required this.isMyCar,
      required this.changeActiveStatus,
      required this.deleteCardDeals});
  final CarModel car;
  final bool isMyCar;
  final Function changeActiveStatus;
  final Function deleteCardDeals;
  String getTimeAgo(DateTime postedTime) {
    final now = DateTime.now();
    final difference = now.difference(postedTime);

    if (difference.inDays > 0) {
      final days = difference.inDays;
      return '${days == 1 ? '1 day' : '$days days'} ago';
    } else if (difference.inHours > 0) {
      final hours = difference.inHours;
      return '${hours == 1 ? '1 hour' : '$hours hours'} ago';
    } else if (difference.inMinutes > 0) {
      final minutes = difference.inMinutes;
      return '${minutes == 1 ? '1 min' : '$minutes mins'} ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 14, left: 16, right: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.myBlue),
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarosuselWithDots(
            images: car.images,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      text:
                          "Posted At : ", // '${AppLocalizations.of(context)!.date} :',
                      style: AppTextStyles.style15w500(),
                      children: [
                    TextSpan(
                        text: getTimeAgo(car.createdAt), // lead.at,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                  ])),
              isMyCar
                  ? !car.isVerified
                      ? SubmitButton(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditCarScreen(car: car),
                                ));
                          },
                          lable: "Edit",
                          width: 50,
                          height: 24,
                          borderRadius: 6,
                          labelsize: 13,
                        )
                      : const SizedBox()
                  : const SizedBox(),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
              text: TextSpan(
                  text:
                      "Model : ", // '${AppLocalizations.of(context)!.date} :',
                  style: AppTextStyles.style15w500(),
                  children: [
                TextSpan(
                    text: car.model, // lead.at,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold))
              ])),
          const SizedBox(
            height: 5,
          ),
          RichText(
              text: TextSpan(
                  text: "Year : ", // '${AppLocalizations.of(context)!.date} :',
                  style: AppTextStyles.style15w500(),
                  children: [
                TextSpan(
                    text: car.year, // lead.at,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold))
              ])),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Location : ",
                style: AppTextStyles.style15w500(),
              ),
              Text(car.location,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold))
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
              text: TextSpan(
                  text:
                      "Price : ", // '${AppLocalizations.of(context)!.date} :',
                  style: AppTextStyles.style15w500(),
                  children: [
                TextSpan(
                    text: "₹${car.price}", // lead.at,
                    style: const TextStyle(
                        color: AppColors.myBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold))
              ])),
          const SizedBox(
            height: 5,
          ),
          RichText(
              text: TextSpan(
                  text:
                      "Details : ", // '${AppLocalizations.of(context)!.date} :',
                  style: const TextStyle(
                    color: AppColors.myBlue,
                    fontSize: 15,
                  ),
                  children: [
                TextSpan(
                    text: car.details, // lead.at,
                    style: const TextStyle(fontSize: 14, color: Colors.black))
              ])),
          const SizedBox(
            height: 8,
          ),
          !isMyCar
              ? SubmitButton(
                  onTap: () async {
                    if (DriverService
                        .instance.driverModel!.membership!.active) {
                      launchUrl(Uri.parse("tel:${car.phoneNo}"));
                    } else {
                      // Navigator.of(context).push(MaterialPageRoute<Null>(
                      //     builder: (BuildContext context) {
                      //       return const PlansScreen();
                      //     },
                      //     fullscreenDialog: true));
                    }
                  },
                  lable: "Call Now",
                  borderRadius: 5,
                  height: 45,
                )
              : car.isVerified
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Toggle Button
                        const Text(
                          "Verified",
                          style: TextStyle(color: Colors.green, fontSize: 14),
                        ),
                        Row(
                          children: [
                            const Text("Active: ",
                                style: TextStyle(fontSize: 15)),
                            SizedBox(
                              height: 38,
                              width: 60,
                              child: FittedBox(
                                child: Switch(
                                  activeColor: Colors.green,
                                  value: car
                                      .active, // Assuming you have a field for job activity status
                                  onChanged: (bool value) {
                                    changeActiveStatus();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Delete Button
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(
                            Icons.delete,
                            size: 26,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteCardDeals();
                          },
                        ),
                      ],
                    )
                  : const Text(
                      "Verification Pending",
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
        ],
      ),
    );
  }
}
