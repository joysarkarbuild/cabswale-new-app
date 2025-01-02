import 'dart:async';
import 'dart:convert';
import 'package:cabswalle/services/logger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class LocationService {
  // Singleton instance
  static final LocationService _instance = LocationService._internal();

  factory LocationService() => _instance;

  LocationService._internal();

  // Private fields
  Position? _currentPosition;
  bool? _locationUpdateOn;
  Timer? _locationUpdateTimer;

  // Getter for current position
  Position? get currentPosition => _currentPosition;

  bool? get locationUpdateOn => _locationUpdateOn;

  // Initialize the service
  Future<void> initialize() async {
    await _handlePermission();
    await _updatePosition();
    _startBackgroundLocationUpdates();
  }

  // Handles location permission
  Future<void> _handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission permanently denied");
    }
  }

  // Fetches the current position
  Future<void> _updatePosition() async {
    if (_locationUpdateOn ?? true) {
      try {
        _currentPosition = await Geolocator.getCurrentPosition();
        await updateDriverLocation();
      } catch (e) {
        LoggerService.logInfo("Failed to get current position: $e");
      }
    }
  }

  Future<void> updateDriverLocation() async {
    if (_currentPosition != null && FirebaseAuth.instance.currentUser != null) {
      const apiUrl =
          'https://us-central1-bwi-cabswalle.cloudfunctions.net/typesense-updateDriverLocation';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'driverId': FirebaseAuth.instance.currentUser!.uid,
          'lat': _currentPosition!.latitude,
          'long': _currentPosition!.longitude,
        }),
      );

      if (response.statusCode == 200) {
        LoggerService.logInfo("Updated position: $_currentPosition");
      } else {
        LoggerService.logError("Location Update Failes");
      }
    }
  }

  void locationUpdateOnOff(bool val) {
    _locationUpdateOn = val;
  }

  // Starts background location updates
  void _startBackgroundLocationUpdates() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer =
        Timer.periodic(const Duration(minutes: 3), (_) async {
      await _updatePosition();
    });
  }

  // Public method to get the current position on demand
  Future<Position?> getCurrentPosition() async {
    await _updatePosition();
    return _currentPosition;
  }

  // Dispose the service and stop updates
  void dispose() {
    _locationUpdateTimer?.cancel();
  }
}
