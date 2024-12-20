import 'dart:io';
import 'package:cabswalle/modules/insurance/insurance_screen2.dart';
import 'package:cabswalle/modules/insurance/insurance_screen3.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/banner_widget.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/common_widget_componants.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart' as path;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class InsuranceScreen1 extends StatefulWidget {
  const InsuranceScreen1({super.key});

  @override
  State<InsuranceScreen1> createState() => _InsuranceScreen1State();
}

Map<String, dynamic> insuranceMap = {};

class _InsuranceScreen1State extends State<InsuranceScreen1> {
  List<String> uploadedFiles = []; // Store uploaded file URLs locally
  bool isLoading = false;
  bool isMainLoading = true;
  Map<String, dynamic> paymentDetails = {};

  void getData() async {
    var razorPayData = await FirebaseFirestore.instance
        .collection("settings")
        .doc("razorpay")
        .get();
    paymentDetails = razorPayData.data()!;

    var data = await FirebaseFirestore.instance
        .collection("insuranceRequests")
        .where("phoneNo",
            isEqualTo: DriverService.instance.driverModel!.phoneNo!)
        .get();
    insuranceMap = data.docs.isNotEmpty
        ? {"docId": data.docs[0].id, ...data.docs[0].data()}
        : {};
    setState(() {
      isMainLoading = false;
    });
    if (insuranceMap["status"] != null) {
      if (insuranceMap["status"] == "pending" ||
          insuranceMap["status"] == "quotation") {
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => InsuranceScreen2(
                paymentDetails: paymentDetails,
              ),
            ));
      } else if (insuranceMap["status"] == "completed") {
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => InsuranceScreen3(),
            ));
      }
    }
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thank You'),
          content: Text(
              'Your application has been submited. Our team will contact you soon.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to pick and upload new files
  Future<void> _pickAndUploadFile() async {
    try {
      // Allow multiple file selection
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'docx'],
      );

      if (result != null) {
        setState(() {
          isLoading = true;
        });

        // Loop through all selected files and upload each
        for (PlatformFile file in result.files) {
          String fileName = path.basename(file.path!);
          String fileType = file.extension!;

          // Upload to Firebase Storage
          Reference storageRef =
              FirebaseStorage.instance.ref().child('insurance_files/$fileName');

          UploadTask uploadTask = storageRef.putFile(
            File(file.path!),
            SettableMetadata(contentType: 'application/$fileType'),
          );

          TaskSnapshot snapshot = await uploadTask;
          String fileURL = await snapshot.ref.getDownloadURL();

          // Add file URL to the local list
          setState(() {
            uploadedFiles.add(fileURL); // Append the new file URL to the list
          });
        }
      }
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to remove files locally
  Future<void> _removeFile(String fileUrl) async {
    try {
      // Remove the file from Firebase Storage
      await FirebaseStorage.instance.refFromURL(fileUrl).delete();

      // Remove file from the local list
      setState(() {
        uploadedFiles.remove(fileUrl);
      });
    } catch (e) {
      SnackbarUtils.showErrorSnackBar(message: e.toString());
    }
  }

  // Function to identify if the file is an image
  bool _isImageFile(String fileUrl) {
    return fileUrl.contains('.jpg') ||
        fileUrl.contains('.jpeg') ||
        fileUrl.contains('.png');
  }

  // Function to identify if the file is a PDF
  bool _isPdfFile(String fileUrl) {
    return fileUrl.contains('.pdf');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Insurance"),
      ),
      body: isMainLoading
          ? CentreLoading()
          : SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 100,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BannerImage(
                        bannerId: "insurance1",
                        onTap: () {
                          launchUrl(Uri.parse("tel:+919403890306"));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 8),
                        child: SubmitButton(
                          borderRadius: 4,
                          onTap: _pickAndUploadFile,
                          lable: isLoading
                              ? "Uploading..."
                              : "Upload Insurance Policy",
                        ),
                      ),
                      if (uploadedFiles.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 10, top: 8),
                          child: SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: uploadedFiles.length,
                              itemBuilder: (context, index) {
                                String fileUrl = uploadedFiles[index];
                                return SizedBox(
                                  width: 90,
                                  child: Column(
                                    children: [
                                      if (_isImageFile(fileUrl))
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: CommonImageView(
                                            url: fileUrl,
                                            height: 50,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      if (_isPdfFile(fileUrl))
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 6),
                                          child: SizedBox(
                                            height: 50,
                                            width: 150,
                                            child: SfPdfViewer.network(fileUrl),
                                          ),
                                        ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () => _removeFile(fileUrl),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      BannerImage(
                        bannerId: "insurance2",
                        onTap: () {
                          launchUrl(Uri.parse("tel:+919403890306"));
                        },
                      ),
                      if (uploadedFiles.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 8),
                          child: SubmitButton(
                            borderRadius: 4,
                            onTap: () async {
                              try {
                                if (uploadedFiles.isNotEmpty) {
                                  var currentUser =
                                      DriverService.instance.driverModel!;
                                  await FirebaseFirestore.instance
                                      .collection("insuranceRequests")
                                      .doc()
                                      .set({
                                    "name": currentUser.name!.isNotEmpty
                                        ? currentUser.name
                                        : "Cabswale Partner",
                                    "phoneNo": currentUser.phoneNo,
                                    "createdAt": DateTime.now(),
                                    "updatedAt": DateTime.now(),
                                    "status": "pending",
                                    "docs": uploadedFiles,
                                  });
                                  _showThankYouDialog();
                                } else {
                                  mySnackBar(
                                      context, "Please upload some documents!");
                                }
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                mySnackBar(context, "Something went wrong!");
                              }
                            },
                            lable: "Submit",
                          ),
                        ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "If you are facing any issues, connect with us",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      String url = 'https://wa.me/9368006253/';
                                      await launchUrl(Uri.parse(url));
                                      debugPrint('sending message: $url');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.42,
                                          40),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/whatsapp.svg',
                                          height: 26,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'WhatsApp',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      launchUrl(Uri.parse("tel:+91940389036"));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.42,
                                          40),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Call',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Text(
                            "Timing: Monday to Sunday 9am to 12am",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
