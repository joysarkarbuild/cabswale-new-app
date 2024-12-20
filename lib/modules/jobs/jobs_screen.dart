import 'package:cabswalle/core/app_colors.dart';
import 'package:cabswalle/modules/jobs/add_jobs.dart';
import 'package:cabswalle/modules/jobs/data/models/job_model.dart';
import 'package:cabswalle/modules/jobs/my_jobs_screen.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/typesense_service.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cabswalle/widgets/search_box.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:url_launcher/url_launcher.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<JobModel> _jobs = [];
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
        .collection('jobs')
        .where('active', isEqualTo: true)
        .where('isVerified', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(5);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;

      final List<JobModel> newJobs = snapshot.docs
          .map((doc) => JobModel.fromJson(doc.data() as Map<String, dynamic>))
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
      isFirst = false;
      _isLoading = false;
    });
  }

  TypeSenseInstance typeSenseInstance = TypeSenseInstance();

  void onSearch(String search) async {
    if (search.isEmpty) {
      _refreshJobs();
      return;
    }
    var data = await typeSenseInstance.getSearchJobs(search);
    _jobs.clear();
    _jobs.addAll(data);
    setState(() {
      _hasMore = false; // No more documents
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
        title: const Text("Jobs"),
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
                            builder: (context) => const MyJobsScreen(),
                          ));
                    },
                    lable: "My Jobs",
                    icon: const Icon(
                      Icons.badge,
                      color: AppColors.myWhite,
                    ),
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.46,
                  ),
                  SubmitButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddJobScreen(
                              isMain: false,
                            ),
                          ));
                    },
                    borderRadius: 5,
                    lable: "Add Jobs",
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.myWhite,
                    ),
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.46,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: SearchBox(onChanged: onSearch),
            ),
            Expanded(
              child: (_isLoading && isFirst)
                  ? const CentreLoading()
                  : _jobs.isEmpty
                      ? Center(
                          child: Text(
                            "No jobs available",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              _jobs.length + (_isLoading || _hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < _jobs.length) {
                              return JobCard(
                                job: _jobs[index],
                                isMyJob: false,
                                deleteJob: () {},
                                changeActiveStatus: () {},
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

class JobCard extends StatelessWidget {
  final JobModel job;
  final bool isMyJob;
  final Function deleteJob;
  final Function changeActiveStatus;

  const JobCard(
      {super.key,
      required this.job,
      required this.isMyJob,
      required this.deleteJob,
      required this.changeActiveStatus});

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
      margin: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
      padding: EdgeInsets.only(
          left: 14, right: 14, bottom: job.isVerified ? 5 : 14, top: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "Posted At : ",
              style: const TextStyle(fontSize: 15, color: Colors.black),
              children: [
                TextSpan(
                  text: getTimeAgo(job.createdAt),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Text("Location : ", style: TextStyle(fontSize: 15)),
              Text(job.location,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              text: "Description : ",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.blue,
              ),
              children: [
                TextSpan(
                  text: job.details,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(
            height: job.isVerified ? 0 : 6,
          ),
          if (!isMyJob)
            const SizedBox(
              height: 8,
            ),
          // Show the toggle and delete buttons if isMyJob is true
          isMyJob
              ? job.isVerified
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
                                  value: job
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
                            deleteJob();
                          },
                        ),
                      ],
                    )
                  : const Text(
                      "Verification Pending",
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    )
              : SubmitButton(
                  onTap: () async {
                    if (DriverService
                        .instance.driverModel!.membership!.active) {
                      launchUrl(Uri.parse("tel:${job.phoneNo}"));
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
                ),
          if (!isMyJob)
            const SizedBox(
              height: 8,
            ),
        ],
      ),
    );
  }
}
