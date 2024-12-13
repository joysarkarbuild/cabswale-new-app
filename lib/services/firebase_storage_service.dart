import 'dart:io';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cabswalle/services/login_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class FirebaseStorageService {
  static Future<String?> uploadProfileImageToFirebase(File file) async {
    try {
      // Compress the image to around 200 KB
      final compressedFile = await _compressImage(file, 200 * 1024); // 200 KB

      if (compressedFile == null) {
        throw Exception("Image compression failed");
      }

      // Upload to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child(
          "profilePics/${LoginManager.userId}${path.basename(file.path)}");
      final uploadTask = await storageRef.putFile(compressedFile);

      // Get download URL
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      LoggerService.logError("Error uploading image: $e");
      return null;
    }
  }

  static Future<String?> uploadVehicleImage(File file) async {
    try {
      // Compress the image to around 200 KB
      final compressedFile = await _compressImage(file, 200 * 1024); // 200 KB

      if (compressedFile == null) {
        throw Exception("Image compression failed");
      }

      // Upload to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child("vehicles/${LoginManager.userId}${path.basename(file.path)}");
      final uploadTask = await storageRef.putFile(compressedFile);

      // Get download URL
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      LoggerService.logError("Error uploading image: $e");
      return null;
    }
  }

  static Future<File?> _compressImage(File file, int targetSizeInBytes) async {
    int quality = 90;
    File? compressedFile;

    while (true) {
      // Get temporary directory to save the compressed file
      final tempDir = await getTemporaryDirectory();

      // Ensure the file has a .jpg extension for compatibility with compression
      String targetPath = path.join(
        tempDir.path,
        "${path.basenameWithoutExtension(file.path)}.jpg",
      );

      // Compress the image with the current quality level
      XFile? temp = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
        format: CompressFormat.jpeg, // Ensure it is compressed to JPG format
      );

      if (temp == null) return null; // Return null if compression fails
      compressedFile = File(temp.path);

      // Check if compression succeeded and file size is within target size
      if (compressedFile.lengthSync() <= targetSizeInBytes) {
        break;
      }

      // Reduce the quality for further compression if size is still above the limit
      quality -= 10;

      // Stop if quality is too low to avoid over-compressing
      if (quality < 10) {
        break;
      }
    }

    return compressedFile;
  }
}
