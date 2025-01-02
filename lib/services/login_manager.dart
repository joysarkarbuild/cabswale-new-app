import 'package:cabswalle/routes/app_routes.dart';
import 'package:cabswalle/services/firestore_service.dart';
import 'package:cabswalle/services/loading_overlay_service.dart';
import 'package:cabswalle/services/single_device_login_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginManager {
  static final LoginManager _instance = LoginManager._internal();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final SingleLoginService singleLoginService = SingleLoginService();
  LoginManager._internal();

  factory LoginManager() {
    return _instance;
  }

  static String? userId;
  static String? jwtToken;
  static bool isLogin = false;
  static String? phoneNo;

  // Send OTP to the phone number
  Future<void> sendOtp({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(FirebaseAuthException e) onError,
    required BuildContext context,
  }) async {
    try {
      LoadingOverlay().show(context);
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 4),
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException e) {
          LoggerService.logError("Verification failed: ${e.message}");
          LoadingOverlay().hide();
          onError(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          LoggerService.logInfo("Code sent to $phoneNumber");
          LoadingOverlay().hide();
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          LoggerService.logWarning("Auto-retrieval timed out for $phoneNumber");
        },
      );
    } catch (e) {
      LoggerService.logError("Error sending OTP: $e");
      rethrow;
    }
  }

  Future<void> verifyOtpUsingOtpLess({
    required String token,
    required BuildContext context,
  }) async {
    try {
      LoggerService.logInfo("Verify firebase called");
      await _auth.signInWithCustomToken(token);
      LoggerService.logInfo("User logged in with OTP");
      await _updateLoginState();
      await singleLoginService.updateSessionId();
      // ignore: use_build_context_synchronously
      context.goNamed(Names.navbar);
    } on FirebaseAuthException catch (e) {
      LoggerService.logError("Error verifying OTP: ${e.message}");
      String errorMessage;

      // Handle specific Firebase exceptions
      switch (e.code) {
        case 'invalid-verification-code':
          errorMessage = "The OTP you entered is invalid. Please try again.";
          break;
        case 'session-expired':
          errorMessage =
              "The verification session has expired. Please request a new OTP.";
          break;
        case 'too-many-requests':
          errorMessage = "Too many attempts. Please try again later.";
          break;
        default:
          errorMessage = "An unknown error occurred. Please try again.";
      }

      SnackbarUtils.showErrorSnackBar(message: errorMessage);
    } catch (e) {
      LoggerService.logError("Unexpected error verifying OTP: $e");
      SnackbarUtils.showErrorSnackBar(
          message: "An unexpected error occurred. Please try again.");
    }
  }

  Future<void> verifyOtp({
    required String verificationId,
    required String smsCode,
    required BuildContext context,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      LoggerService.logInfo("User logged in with OTP");
      await _updateLoginState();
      // ignore: use_build_context_synchronously
      context.goNamed(Names.splash);
    } on FirebaseAuthException catch (e) {
      LoggerService.logError("Error verifying OTP: ${e.message}");
      String errorMessage;

      // Handle specific Firebase exceptions
      switch (e.code) {
        case 'invalid-verification-code':
          errorMessage = "The OTP you entered is invalid. Please try again.";
          break;
        case 'session-expired':
          errorMessage =
              "The verification session has expired. Please request a new OTP.";
          break;
        case 'too-many-requests':
          errorMessage = "Too many attempts. Please try again later.";
          break;
        default:
          errorMessage = "An unknown error occurred. Please try again.";
      }

      SnackbarUtils.showErrorSnackBar(message: errorMessage);
    } catch (e) {
      LoggerService.logError("Unexpected error verifying OTP: $e");
      SnackbarUtils.showErrorSnackBar(
          message: "An unexpected error occurred. Please try again.");
    }
  }

  // Update login state
  Future<void> _updateLoginState() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      userId = currentUser.uid;
      jwtToken = await currentUser.getIdToken();
      isLogin = true;
      phoneNo = currentUser.phoneNumber;
      LoggerService.logInfo("UserId: $userId");
      LoggerService.logInfo("JwtToken: $jwtToken");
      LoggerService.logInfo("IsLogin: $isLogin");
      LoggerService.logInfo("PhoneNo: $phoneNo");
    } else {
      userId = null;
      jwtToken = null;
      isLogin = false;
    }
  }

  Future<bool> isBlock(String phoneNumber) async {
    bool isBlocked = false;
    try {
      await FirebaseFirestore.instance
          .collection('drivers')
          .where('phoneNo', isEqualTo: phoneNumber)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty && value.docs[0]['isBlocked'] != null) {
          if (value.docs[0]['isBlocked']) {
            LoggerService.logError('$phoneNumber is blocked');
            isBlocked = true;
          }
        }
      });
    } catch (e) {
      isBlocked = false;
      LoggerService.logInfo(
          'error found at auth_provider.dart/isBlock()\nerror : $e');
    }
    LoggerService.logInfo('isblock : $isBlocked');

    return isBlocked;
  }

  Future<void> setActive(String phoneNo) async {
    await FirebaseFirestore.instance
        .collection('loginPhno')
        .doc(phoneNo)
        .set({'active': true, 'phoneNo': phoneNo}, SetOptions(merge: true));
    LoggerService.logInfo("Set Active : true");
  }

  // Get login status
  bool getLoginStatus() {
    return isLogin;
  }

  // Get current user ID
  String? getUserId() {
    return userId;
  }

  // Get current JWT token
  String? getJwtToken() {
    return jwtToken;
  }

  // Logout user
  Future<void> logout() async {
    await _auth.signOut();
    await _updateLoginState();
    LoggerService.logInfo("User logged out");
  }

  Future<void> deleteAccount() async {
    FirestoreUtils firestoreUtils = FirestoreUtils();
    await firestoreUtils
        .updateDocument("drivers", userId ?? "", {"isDeleted": true});
    await logout();
  }

  // Get all user data
  Future<void> getAllData() async {
    await _updateLoginState();
  }

  // Clear login status, JWT token, and user ID (logout)
  Future<void> clearLoginStatus() async {}
}
