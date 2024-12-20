import 'package:cabswalle/modules/loan/data/models/loan_data_nodel.dart';
import 'package:cabswalle/modules/loan/screen/loan_details_screen.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({
    super.key,
  });
  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  List<LoanModel> products = [];
  bool isLoading = true;
  bool isLoadingMore = false;
  DocumentSnapshot? lastDocument;
  final ScrollController _scrollController = ScrollController();
  final int _limit = 10;
  int walletBalance = 0;

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("loans")
        .limit(_limit)
        .get();

    products.addAll(querySnapshot.docs
        .map((e) => LoanModel.fromJson(
            {...e.data() as Map<String, dynamic>, "id": e.id}))
        .toList());

    if (querySnapshot.docs.isNotEmpty && (querySnapshot.docs.length == 1)) {
      lastDocument = querySnapshot.docs.last;

      // Automatically navigate to LoanDetailsScreen for the first loan
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoanDetailsScreen(product: products.first),
          ),
        );
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void getMoreData() async {
    if (lastDocument == null) return;
    setState(() {
      isLoadingMore = true;
    });
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("products")
        .startAfterDocument(lastDocument!)
        .limit(_limit)
        .get();
    products.addAll(querySnapshot.docs
        .map((e) => LoanModel.fromJson(
            {...e.data() as Map<String, dynamic>, "id": e.id}))
        .toList());
    if (querySnapshot.docs.isNotEmpty) {
      lastDocument = querySnapshot.docs.last;
    }
    setState(() {
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loan"),
        centerTitle: true,
      ),
      body: isLoading
          ? CentreLoading()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(14),
                    itemCount: products.length + 1,
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        final e = products[index];
                        return InkWell(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("clicks")
                                .add({
                              "driverId":
                                  FirebaseAuth.instance.currentUser!.uid,
                              "id": e.id,
                              "branchId": "",
                              "type": "loan",
                              "createdAt": DateTime.now(),
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LoanDetailsScreen(product: e),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: CommonImageView(
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                url: e.coverPic),
                          ),
                        );
                      } else if (isLoadingMore) {
                        return CentreLoading();
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
