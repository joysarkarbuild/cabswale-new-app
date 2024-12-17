import 'dart:async';
import 'package:cabswalle/services/logger_service.dart';
import 'package:geolocator/geolocator.dart';

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
        LoggerService.logInfo("Updated position: $_currentPosition");
      } catch (e) {
        LoggerService.logInfo("Failed to get current position: $e");
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
