import 'dart:io';
import 'package:cabswalle/modules/reportScreen/data/models/fraud_model.dart';
import 'package:cabswalle/widgets/banner_widget.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key, required this.fraud});

  final FraudModel fraud;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool showp = false;
  bool status = false;
  bool issubmitactive = false;
  TextEditingController reporrDetails = TextEditingController();
  List<File> selectedImages = []; // List to hold selected images

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile;

    // Select Image
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImages.add(File(pickedFile!.path)); // Add selected image
        issubmitactive = true; // Enable submit button
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: myAppBar(
          context: context,
          backgroundColor: Colors.white,
          title: 'Report Fraud',
          centerTitle: true),
      body: !status
          ? SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BannerImage(bannerId: "fraud"),
                        SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "Enter your Report",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: reporrDetails,
                            minLines: 8,
                            maxLines: 10,
                          ),
                        ),
                        if (selectedImages.isNotEmpty)
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedImages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Image.file(selectedImages[index],
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            setState(() {
                                              selectedImages.removeAt(index);
                                              if (selectedImages.isEmpty) {
                                                issubmitactive =
                                                    false; // Disable submit button if no images selected
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ElevatedButton(
                          onPressed: _pickImage, // Call the _pickImage method
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            minimumSize: Size(180, 46),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                          ),
                          child: Text(
                            'Select Screenshots',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 140,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (FirebaseAuth.instance.currentUser == null) {
                                Fluttertoast.showToast(
                                    msg: 'Please login to report');
                              } else {
                                if (!issubmitactive) {
                                  Fluttertoast.showToast(
                                      msg: 'Upload Payment Screenshot first');
                                } else {
                                  setState(() {
                                    showp = true;
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('drivers')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .get()
                                      .then((value) async {
                                    List<String> imageUrls = [];
                                    // Upload images to Firebase Storage
                                    for (File imageFile in selectedImages) {
                                      File? compressedFile =
                                          await _compressImage(
                                              imageFile, 300000);
                                      final firebaseStorage =
                                          FirebaseStorage.instance;
                                      var snapshot = await firebaseStorage
                                          .ref(
                                              "Payment Images/${DateTime.now()}")
                                          .putFile(compressedFile!);

                                      String imageUrl =
                                          await snapshot.ref.getDownloadURL();
                                      imageUrls.add(imageUrl);
                                    }

                                    // Add report details to Firestore
                                    await FirebaseFirestore.instance
                                        .collection('fraudReports')
                                        .add({
                                      'createdAt': DateTime.now(),
                                      'message': reporrDetails.text,
                                      'images': imageUrls,
                                      'phoneNo': value['phoneNo'],
                                      'status': false,
                                      'uploadedBy': {
                                        'id': value.id,
                                        'name': value['name']
                                      },
                                      'fraudUser': {
                                        'id': widget.fraud.id,
                                        'name': widget.fraud.name
                                      },
                                      'leadId': widget.fraud.leadId,
                                    }).then((value) async {
                                      setState(() {
                                        status = true;
                                        showp = false;
                                      });
                                    });
                                  });
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  issubmitactive ? Colors.blue : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                              minimumSize: Size(120, 40),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                            ),
                            child: showp
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Text(
                    'Thank You',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Your fraud report is pending for verification.',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        minimumSize: Size(
                            100, 30), // Adjust the size as per your requirement
                        padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical:
                                6), // Adjust the padding as per your requirement
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Back to Home',
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}
