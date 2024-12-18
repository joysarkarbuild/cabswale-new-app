import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/services/firestore_service.dart';

class CommunityService {
  // Singleton instance
  static final CommunityService _instance = CommunityService._internal();

  // Private constructor
  CommunityService._internal();

  // Factory constructor to return the singleton instance
  factory CommunityService() => _instance;

  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  // Cached community data
  Map<String, dynamic>? _communityData;

  // Fetch community data from Firestore
  Future<Map<String, dynamic>> getCommunityData() async {
    if (_communityData != null) {
      return _communityData!;
    }

    final communityDoc =
        await _firestoreUtils.getDocument("settings", "community");
    _communityData = communityDoc?.data() as Map<String, dynamic>;
    return _communityData!;
  }
}
