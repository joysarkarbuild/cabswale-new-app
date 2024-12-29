import 'package:cabswalle/modules/buySellCar/data/models/car_model.dart';
import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:cabswalle/modules/jobs/data/models/job_model.dart';
import 'package:cabswalle/modules/nearbyPlace/data/models/nearby_place_model.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:typesense/typesense.dart';

class TypeSenseInstance {
  late final Configuration config;
  late final Client client;

  // Static private instance of the class
  static final TypeSenseInstance _instance = TypeSenseInstance._internal();

  // Private constructor
  TypeSenseInstance._internal();

  // Factory constructor to return the same instance
  factory TypeSenseInstance() {
    return _instance;
  }

  Future<void> getKeys() async {
    await FirebaseFirestore.instance
        .collection('settings')
        .doc('typesense')
        .get()
        .then((value) {
      var keys = value.data();

      debugPrint(keys.toString());
      config = Configuration(
        keys!['searchOnlyKey'].toString(),
        nodes: {
          Node(
            Protocol.https,
            keys['host'].toString(),
            port: 443,
          )
        },
      );
      client = Client(config);
    });
  }

  Future<List> getCities({required String query}) async {
    var searchParameters = {
      'q': query,
      'query_by': '_text_',
      'typo_tolerance': 1,
    };
    try {
      final result = await client
          .collection('bwi-cabswalle-settings')
          .documents
          .search(searchParameters) as Map;
      return result['hits'];
    } catch (e) {
      debugPrint("error while getting cities");
      debugPrint("Error : $e");
      return [];
    }
  }

  Future<List> getVerifiedDrivers(type, page) async {
    var searchPerameters;
    if (type == 'verified') {
      searchPerameters = {
        'q': "*",
        'filter_by': 'verified:= true&&fraud:=false',
        'per_page': '50',
        'page': page.toString()
      };
    } else if (type == 'fraud') {
      searchPerameters = {
        'q': "*",
        'filter_by': 'fraud:=true',
        'per_page': '50',
        'page': page.toString()
      };
    } else if (type == 'notVerified') {
      searchPerameters = {
        'q': "*",
        'filter_by': 'verified:=false',
        'per_page': '50',
        'page': page.toString()
      };
    }
    try {
      final result = await client
          .collection('bwi-cabswalle-drivers')
          .documents
          .search(searchPerameters) as Map;

      return result['hits'];
    } catch (e) {
      debugPrint("error while getting verified drivers");
      debugPrint("Error : $e");
      return [];
    }
  }

  Future<List> getSearch(query) async {
    var searchPerameters = {
      'q': query,
      'query_by': 'name, city, phoneNo',
      'per_page': '50',
    };
    try {
      final result = await client
          .collection('bwi-cabswalle-drivers')
          .documents
          .search(searchPerameters) as Map;
      return result['hits'];
    } catch (e) {
      debugPrint("error while getting verified drivers");
      debugPrint("Error : $e");
      return [];
    }
  }

  Future<List<NearbyPlace>> getNearbyPlace(String collectionName, int page,
      double lat, double long, int radius, String searchText) async {
    var query = {
      'q': searchText.isEmpty ? "*" : searchText,
      'query_by': "name,address",
      "filter_by": "location:($lat,$long,${radius}km)",
      "sort_by": "location($lat,$long):asc",
      'page': page.toString(),
      'per_page': 150.toString(),
    };

    try {
      final result = await client
          .collection(collectionName)
          .documents
          .search(query) as Map;

      debugPrint("Result: $result");

      List<NearbyPlace> nearbyList = [];
      for (var item in result['hits']) {
        nearbyList.add(NearbyPlace.fromJson(item));
      }

      return nearbyList;
    } catch (e) {
      return [];
    }
  }

  Future<List<LeadModel>> getSearchedLeadsTS(String search, int page) async {
    LoggerService.logInfo('searhing for $search... \nPage : $page');

    List<LeadModel> leadsList = [];
    final searchPerameters = {
      'q': search,
      'query_by': 'fromTxt',
      'filter_by': 'status:!=pending',
      'sort_by': 'createdAt:desc',
      'per_page': '30',
      'page': page.toString(),
    };
    try {
      final result = await client
          .collection('bwi-cabswalle-leads')
          .documents
          .search(searchPerameters) as Map;

      for (var item in result['hits']) {
        var elemenetfound = false;

        for (var element in leadsList) {
          if (element.id == item['document']['id']) {
            elemenetfound = true;
          }
        }
        if (!elemenetfound) {
          leadsList.add(LeadModel.fromJson(
              {"id": item['document']['id'], ...item['document']}));
        }
      }
      return leadsList;
    } catch (e) {
      LoggerService.logError(e.toString());
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      return leadsList;
    }
  }

  Future<List<LeadModel>> getMyLocationLeads(
      Position position, int page) async {
    LoggerService.logInfo(
        'searhing for Position ${position.latitude} , ${position.longitude}... \nPage : $page');
    List<LeadModel> leadsList = [];
    final searchPerameters = {
      'q': "*",
      'query_by': 'fromTxt',
      'filter_by':
          'location:(${position.latitude},${position.longitude},${100} km)&&status:!=pending',
      'sort_by':
          "createdAt:desc,location(${position.latitude},${position.latitude}):asc",
      'per_page': '20',
      'page': page.toString()
    };
    try {
      final result = await client
          .collection('bwi-cabswalle-leads')
          .documents
          .search(searchPerameters) as Map;

      for (var item in result['hits']) {
        leadsList.add(LeadModel.fromJson(item['document']));
      }
      return leadsList;
    } catch (e) {
      LoggerService.logError(e.toString());
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      return leadsList;
    }
  }

  Future<List> getNearbyDrivers(
      {required double lat, required double long, required int raduis}) async {
    LoggerService.logInfo("Fetching Nearby Druver");
    var searchParameters = {
      'q': '*',
      'query_by': 'name',
      "filter_by":
          "currentLocation:($lat,$long, $raduis km)&&locationUpdatedAt:>${DateTime.now().millisecondsSinceEpoch}",
      "sort_by": "currentLocation($lat,$long):asc"
    };

    try {
      final result = await client
          .collection('bwi-cabswalle-drivers')
          .documents
          .search(searchParameters) as Map;
      return result['hits'];
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      return [];
    }
  }

  Future<List> getPartner(
      {required double lat,
      required double long,
      required int radius,
      required int page,
      required int perPage}) async {
    var searchParameters = {
      "q": '*',
      "query_by": 'location',
      "filter_by": 'address.coordinates:($lat,$long,$radius km)&&active:=true',
      "sort_by": 'address.coordinates($lat,$long):asc',
      "page": "$page",
      "per_page": "$perPage"
    };
    LoggerService.logInfo("Fetching bwi-cabswalle-partnerBranches");

    try {
      final result = await client
          .collection('bwi-cabswalle-partnerBranches')
          .documents
          .search(searchParameters) as Map;

      return result['hits'];
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      return [];
    }
  }

  Future<List<JobModel>> getSearchJobs(String search) async {
    List<JobModel> jobList = [];
    // FieldValue.serverTimestamp();
    final searchPerameters = {
      'q': search,
      'query_by': 'location, details',
      'per_page': "50"
    };

    try {
      final result = await client
          .collection('bwi-cabswalle-jobs')
          .documents
          .search(searchPerameters) as Map;

      for (var item in result['hits']) {
        jobList.add(JobModel.fromJson(item['document']));
      }

      return jobList;
    } catch (e) {
      debugPrint("error while searching leads");
      debugPrint("Error : $e");
      return jobList;
    }
  }

  Future<List<CarModel>> getSearchCars(String search) async {
    List<CarModel> jobList = [];
    // FieldValue.serverTimestamp();
    final searchPerameters = {
      'q': search,
      'query_by': 'model, location, details',
      'per_page': "50",
    };
    try {
      final result = await client
          .collection('bwi-cabswalle-carDeals')
          .documents
          .search(searchPerameters) as Map;

      for (var item in result['hits']) {
        jobList.add(CarModel.fromMap(item['document']));
      }
      return jobList;
    } catch (e) {
      return jobList;
    }
  }
}
