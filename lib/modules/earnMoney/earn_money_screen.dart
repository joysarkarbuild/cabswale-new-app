import 'package:cabswalle/models/partner_setails.dart';
import 'package:cabswalle/modules/nearbyDriver/data/models/nearby_driver_model.dart';
import 'package:cabswalle/services/location_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/services/typesense_service.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cabswalle/widgets/earn_money_card.dart';
import 'package:flutter/material.dart';

class EarnMoneyScreen extends StatefulWidget {
  const EarnMoneyScreen({super.key});

  @override
  State<EarnMoneyScreen> createState() => _EarnMoneyScreenState();
}

class _EarnMoneyScreenState extends State<EarnMoneyScreen> {
  List<Partner> partners = [];
  final TypeSenseInstance typesenceInstance = TypeSenseInstance();
  bool isLoading = true;
  LocationService locationService = LocationService();
  bool isLoadingMore = false;
  bool hasMoreData = true; // Add this flag
  int currentPage = 1;
  final int perPage = 10;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getPartners();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoadingMore &&
          hasMoreData) {
        getMorePartners();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getPartners() async {
    try {
      setState(() {
        isLoading = true;
      });

      List data = await typesenceInstance.getPartner(
          lat: locationService.currentPosition!.latitude,
          long: locationService.currentPosition!.longitude,
          radius: 1000000,
          page: currentPage,
          perPage: perPage);

      setState(() {
        partners = data.map((e) => Partner.fromJson(e["document"])).toList();
        hasMoreData = data.length >= perPage; // Update hasMoreData
        isLoading = false;
      });
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
    }
  }

  void getMorePartners() async {
    try {
      setState(() {
        isLoadingMore = true;
      });
      currentPage++;
      List data = await typesenceInstance.getPartner(
          lat: locationService.currentPosition!.latitude,
          long: locationService.currentPosition!.longitude,
          radius: 10000000,
          page: currentPage,
          perPage: perPage);

      setState(() {
        partners
            .addAll(data.map((e) => Partner.fromJson(e["document"])).toList());
        hasMoreData = data.length >= perPage; // Update hasMoreData
        isLoadingMore = false;
      });
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: "Restaurants",
        centerTitle: true,
      ),
      body: isLoading
          ? CentreLoading()
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(14),
              itemCount: partners.length + (hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < partners.length) {
                  final e = partners[index];
                  return EarnMoneyCard(
                    partner: e,
                    distance: calculateDistanceInMeters(
                        double.parse(e.address.coordinates[0]),
                        double.parse(e.address.coordinates[1])),
                  );
                } else if (isLoadingMore) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Container();
                }
              },
            ),
    );
  }
}
