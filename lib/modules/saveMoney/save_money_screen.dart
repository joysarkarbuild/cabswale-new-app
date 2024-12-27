import 'package:cabswalle/modules/saveMoney/save_money_details_screen.dart';
import 'package:cabswalle/modules/wallet/data/models/product_model.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SaveMoneyScreen extends StatefulWidget {
  const SaveMoneyScreen({
    super.key,
  });

  @override
  State<SaveMoneyScreen> createState() => _SaveMoneyScreenState();
}

class _SaveMoneyScreenState extends State<SaveMoneyScreen> {
  List<ProductModel> products = [];
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

  Future<void> getProfileData() async {
    var userData = await FirebaseFirestore.instance
        .collection("drivers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userData.data()!["wallet"] != null) {
      walletBalance = userData.data()!["wallet"]["amount"];
    }
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
        .collection("products")
        .where("active", isEqualTo: true)
        .limit(_limit)
        .get();
    products.addAll(querySnapshot.docs
        .map((e) => ProductModel.fromJson(
            {...e.data() as Map<String, dynamic>, "id": e.id}))
        .toList());
    if (querySnapshot.docs.isNotEmpty) {
      lastDocument = querySnapshot.docs.last;
    }
    await getProfileData();
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
        .where("active", isEqualTo: true)
        .limit(_limit)
        .get();
    products.addAll(querySnapshot.docs
        .map((e) => ProductModel.fromJson(
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
      appBar: myAppBar(
        title: "Car Services",
        centerTitle: true,
        context: context,
      ),
      body: isLoading
          ? CentreLoading()
          : Column(
              children: [
                const Text(
                  "Buy with your wallet balance",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
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
                              "type": "product",
                              "createdAt": DateTime.now(),
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SaveMoneyDetailsScreen(
                                    product: e,
                                    walletBalance: walletBalance,
                                  ),
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
                        return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Center(child: CircularProgressIndicator()));
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
