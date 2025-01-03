import 'dart:async';
import 'dart:io';

import 'package:cabswalle/modules/myprofile/bloc/myprofile_bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_event.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/my_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class EditAadharAndLicense extends StatefulWidget {
  const EditAadharAndLicense({super.key});

  @override
  State<EditAadharAndLicense> createState() => _EditAadharAndLicenseState();
}

class _EditAadharAndLicenseState extends State<EditAadharAndLicense> {
  final List<String> _aadharUrls = [];
  final List<String> _licenceUrls = [];
  String _aadharNumber = '';
  String _licenceNumber = '';

  TextEditingController aadharController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final ImagePicker _imagePicker = ImagePicker();
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    _fetchExistingData();
  }

  Future<void> _fetchExistingData() async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection("drivers").doc(uid).get();

      if (snapshot.exists) {
        Map<String, dynamic>? aadharData = snapshot.get("aadharCard");
        Map<String, dynamic>? licenceData = snapshot.get("license");

        if (aadharData != null) {
          _aadharNumber = aadharData["id"] ?? '';
          List<String> aadharUrls =
              List<String>.from(aadharData["images"] ?? []);
          setState(() {
            aadharController.text = _aadharNumber;
            _aadharUrls.addAll(aadharUrls);
          });
        }

        if (licenceData != null) {
          _licenceNumber = licenceData["id"] ?? '';
          List<String> licenceUrls =
              List<String>.from(licenceData["images"] ?? []);
          setState(() {
            licenseController.text = _licenceNumber;
            _licenceUrls.addAll(licenceUrls);
          });
        }
      }
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
    }
  }

  Future<void> _getImage(List<String> urls) async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _uploading = true;
      });
      try {
        File imageFile = File(pickedFile.path);
        String imageUrl = await _uploadImage(imageFile);
        setState(() {
          urls.add(imageUrl);
          _uploading = false;
        });
      } catch (e) {
        SnackbarUtils.showErrorSnackBar(message: e.toString());
        setState(() {
          _uploading = false;
        });
      }
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    try {
      String imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('aadhar_images')
          .child(imageName);

      File? compressedFile = await _compressImage(imageFile, 300000);
      firebase_storage.UploadTask uploadTask = ref.putFile(compressedFile!);
      firebase_storage.TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return "";
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

  void _deleteImage(List<String> urls, int index) {
    setState(() {
      urls.removeAt(index);
    });
  }

  Future<void> _saveImages() async {
    if (aadharController.text.isEmpty) {
      SnackbarUtils.showSuccessSnackBar(message: "Please Enter Aadhar number");
      return;
    }

    if (licenseController.text.isEmpty) {
      SnackbarUtils.showSuccessSnackBar(message: "Please Enter License number");
      return;
    }
    if (_aadharUrls.length < 2) {
      Fluttertoast.showToast(
          msg: "Please upload both front and back of Aadhar",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }

    if (_licenceUrls.length < 2) {
      Fluttertoast.showToast(
          msg: "Please upload both front and back of Licence",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      return;
    }

    setState(() {
      _uploading = true;
    });
    _aadharNumber = aadharController.text.trim();
    _licenceNumber = licenseController.text.trim();

    try {
      await FirebaseFirestore.instance.collection("drivers").doc(uid).update({
        "aadharCard": {
          "id": _aadharNumber,
          "images": _aadharUrls,
        },
        "license": {
          "id": _licenceNumber,
          "images": _licenceUrls,
        }
      });
      setState(() {
        _uploading = false;
      });
      // ignore: use_build_context_synchronously
      context.read<MyprofileBloc>().add(MyProfileLoadEvent(userId: ""));
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
      setState(() {
        _uploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upload Aadhar & License",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Enter Aadhar Number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            MyTextFormField(
              hintText: "Aadhar Number",
              borderRadius: 6,
              keyboardType: TextInputType.number,
              textEditingController: aadharController,
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Aadhar Card (Front & Back)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildImageSection(_aadharUrls),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Enter License Number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            MyTextFormField(
              hintText: "License Number",
              borderRadius: 6,
              textEditingController: licenseController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Driving Licence (Front & Back)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildImageSection(_licenceUrls),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: _uploading ? null : _saveImages,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  minimumSize: Size(MediaQuery.of(context).size.width,
                      40), // Adjust the size as per your requirement
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical:
                          6), // Adjust the padding as per your requirement
                ),
                child: _uploading
                    ? CircularProgressIndicator()
                    : const Text('Save',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(List<String> urls) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < urls.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.network(
                        urls[i],
                        height: 150,
                      ),
                      Container(
                        height: 40,
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 12,
                          ),
                          onPressed: () => _deleteImage(urls, i),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            minimumSize: Size(MediaQuery.of(context).size.width,
                40), // Adjust the size as per your requirement
            padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6), // Adjust the padding as per your requirement
          ),
          onPressed: _uploading ? null : () => _getImage(urls),
          child: _uploading
              ? CircularProgressIndicator()
              : const Text('Upload Images',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ],
    );
  }
}
