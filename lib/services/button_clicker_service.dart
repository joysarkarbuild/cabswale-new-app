import 'package:cabswalle/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonClickTracker {
  static const String _prefix = 'ButtonClick_';

  static Future<void> incrementClickCount(String buttonKey) async {
    final prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt(_prefix + buttonKey) ?? 0;
    await prefs.setInt(_prefix + buttonKey, currentCount + 1);
  }

  static Future<int> getClickCount(String buttonKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_prefix + buttonKey) ?? 0;
  }

  static Future<void> clearAllClickCounts() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (var key in keys) {
      if (key.startsWith(_prefix)) {
        await prefs.remove(key);
      }
    }
  }

  static Future<void> resetAllClickCounts() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (var key in keys) {
      if (key.startsWith(_prefix)) {
        await prefs.setInt(key, 0);
      }
    }
  }

  static Future<void> uploadAllClickCounts() async {
    Map<String, int> allClickCounts = await getAllClickCounts();
    Map<String, dynamic> uploadData = {
      'updatedAt': Timestamp.now(),
    };

    allClickCounts.forEach((key, value) {
      uploadData[key] = FieldValue.increment(value);
    });

    try {
      await FirebaseFirestore.instance
          .collection('analytics')
          .doc('buttonClick')
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(uploadData, SetOptions(merge: true));
      LoggerService.logInfo("User analytics updated successfully for all keys");
      await clearAllClickCounts();
    } catch (e) {
      LoggerService.logInfo("Failed to update user analytics for all keys: $e");
    }
  }

  static Future<Map<String, int>> getAllClickCounts() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final Map<String, int> clickCounts = {};
    for (var key in keys) {
      if (key.startsWith(_prefix)) {
        clickCounts[key.replaceFirst(_prefix, '')] = prefs.getInt(key) ?? 0;
      }
    }
    return clickCounts;
  }

  // Increment functions for each button
  static Future<void> incrementMyLeadsClick() async {
    await incrementClickCount('MyLeads');
  }

  static Future<void> incrementVideosClick() async {
    await incrementClickCount('Videos');
  }

  static Future<void> incrementGetDutyAlertsClick() async {
    await incrementClickCount('GetDutyAlerts');
  }

  static Future<void> incrementReportClick() async {
    await incrementClickCount('Report');
  }

  static Future<void> incrementHomePageLocationClick() async {
    await incrementClickCount('HomePageLocation');
  }

  static Future<void> incrementExchangeClick() async {
    await incrementClickCount('Exchange');
  }

  static Future<void> incrementAvailableClick() async {
    await incrementClickCount('Available');
  }

  static Future<void> incrementHomePageBannerClick() async {
    await incrementClickCount('HomePageBanner');
  }

  static Future<void> incrementAddLeadsClick() async {
    await incrementClickCount('AddLeads');
  }

  static Future<void> incrementLocationsTabClick() async {
    await incrementClickCount('LocationsTab');
  }

  static Future<void> incrementCommunityTabClick() async {
    await incrementClickCount('CommunityTab');
  }

  static Future<void> incrementCallsTabClick() async {
    await incrementClickCount('CallsTab');
  }

  static Future<void> incrementProfileTabClick() async {
    await incrementClickCount('ProfileTab');
  }

  static Future<void> incrementLocationsButtonClick() async {
    await incrementClickCount('LocationsButton');
  }

  static Future<void> incrementDriverListClick() async {
    await incrementClickCount('DriverList');
  }

  static Future<void> incrementNearbyDriversClick() async {
    await incrementClickCount('NearbyDrivers');
  }

  static Future<void> incrementVerifyAccountClick() async {
    await incrementClickCount('VerifyAccount');
  }

  static Future<void> incrementConnectionClick() async {
    await incrementClickCount('Connection');
  }

  static Future<void> incrementTopRoutesClick() async {
    await incrementClickCount('TopRoutes');
  }

  static Future<void> incrementTopPickupLocationsClick() async {
    await incrementClickCount('TopPickupLocations');
  }

  static Future<void> incrementTopDropLocationsClick() async {
    await incrementClickCount('TopDropLocations');
  }

  static Future<void> incrementPetrolCNGPumpsClick() async {
    await incrementClickCount('PetrolCNGPumps');
  }

  static Future<void> incrementCarRepairShopsClick() async {
    await incrementClickCount('CarRepairShops');
  }

  static Future<void> incrementTowingServiceNearMeClick() async {
    await incrementClickCount('TowingServiceNearMe');
  }

  static Future<void> incrementAutoPartsStoreClick() async {
    await incrementClickCount('AutoPartsStore');
  }

  static Future<void> incrementServiceStationNearMeClick() async {
    await incrementClickCount('ServiceStationNearMe');
  }

  static Future<void> incrementEmergencyClick() async {
    await incrementClickCount('Emergency');
  }

  static Future<void> incrementVideosFromRealDriversClick() async {
    await incrementClickCount('VideosFromRealDrivers');
  }

  static Future<void> incrementTellUsYourProblemsClick() async {
    await incrementClickCount('TellUsYourProblems');
  }

  static Future<void> incrementChangeLanguageClick() async {
    await incrementClickCount('ChangeLanguage');
  }

  static Future<void> incrementMyProfileClick() async {
    await incrementClickCount('MyProfile');
  }

  static Future<void> incrementHomeScreenSearch() async {
    await incrementClickCount('HomeSearch');
  }

  static Future<void> incrementYourLocationDuties() async {
    await incrementClickCount('YourLocationDuties');
  }

  static Future<void> incrementServiceTab() async {
    await incrementClickCount('ServiceTab');
  }

  static Future<void> incrementCarInsurance() async {
    await incrementClickCount('CarInsurance');
  }

  static Future<void> incrementLoan() async {
    await incrementClickCount('Loan');
  }

  static Future<void> incrementCarService() async {
    await incrementClickCount('CarService');
  }

  static Future<void> incrementJobs() async {
    await incrementClickCount('Jobs');
  }

  static Future<void> incrementRestaurants() async {
    await incrementClickCount('Restaurants');
  }

  static Future<void> incrementBuyAndSellCar() async {
    await incrementClickCount('BuyAndSellCar');
  }

  static Future<void> incrementNearbyClick() async {
    await incrementClickCount('NearbyClick');
  }

  static Future<void> incrementTopLocation() async {
    await incrementClickCount('TopLocation');
  }

  static Future<void> incrementPartnerWithUs() async {
    await incrementClickCount('PartnerWithUs');
  }

  static Future<void> incrementDeals() async {
    await incrementClickCount('PartnerWithUs');
  }

  static Future<void> incrementCabswaleMembership() async {
    await incrementClickCount('CabswaleMembership');
  }

  static Future<void> incrementWalletTransactions() async {
    await incrementClickCount('WalletTransactions');
  }

  static Future<void> incrementSettings() async {
    await incrementClickCount('Settings');
  }

  static Future<void> incrementTermsAndPolicy() async {
    await incrementClickCount('TermsAndPolicy');
  }

  static Future<void> incrementLogout() async {
    await incrementClickCount('Logout');
  }

  static Future<void> incrementDeleteAccount() async {
    await incrementClickCount('DeleteAccount');
  }

  static Future<void> incrementRechargeNow() async {
    await incrementClickCount('RechargeNow');
  }
}
