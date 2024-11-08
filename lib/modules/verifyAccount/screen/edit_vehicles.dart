import 'dart:io';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_state.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_bloc.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_event.dart';
import 'package:cabswalle/services/firebase_storage_service.dart';
import 'package:cabswalle/services/loading_overlay_service.dart';
import 'package:cabswalle/widgets/common_image_view.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditVehicles extends StatefulWidget {
  const EditVehicles({super.key});

  @override
  State<EditVehicles> createState() => _EditVehiclesState();
}

class _EditVehiclesState extends State<EditVehicles> {
  int _numberOfVehicles = 0;
  final List<List<String>> _imageUrls = []; // To store download URLs
  final List<TextEditingController> _vehicleControllers = [];
  final ImagePicker _imagePicker = ImagePicker();
  bool _isUploading = false;

  void setExistingData() {
    if (context.read<MyprofileBloc>().state is MyProfileLoaded) {
      _numberOfVehicles =
          ((context.read<MyprofileBloc>().state as MyProfileLoaded)
                      .myProfile
                      .vehicles ??
                  [])
              .length;
      for (int i = 0; i < _numberOfVehicles; i++) {
        _vehicleControllers.add(TextEditingController(
            text: (context.read<MyprofileBloc>().state as MyProfileLoaded)
                    .myProfile
                    .vehicles![i]["model"] ??
                ""));
        List<String> urls = List<String>.from(
            (context.read<MyprofileBloc>().state as MyProfileLoaded)
                    .myProfile
                    .vehicles![i]["images"] ??
                []);
        _imageUrls.add(urls);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setExistingData();
  }

  void _addVehicle() {
    setState(() {
      _numberOfVehicles++;
      _imageUrls.add([]); // Initialize list for storing URLs
      _vehicleControllers.add(TextEditingController());
    });
  }

  Future<void> _getImage(int index) async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _uploadImage(pickedFile.path, index);
      }
    });
  }

  Future<void> _uploadImage(String imagePath, int index) async {
    setState(() {
      _isUploading = true;
    });

    LoadingOverlay().show(context);

    File file = File(imagePath);
    String downloadUrl =
        await FirebaseStorageService.uploadVehicleImage(file) ?? "";
    if (downloadUrl.isNotEmpty) {
      setState(() {
        _imageUrls[index].add(downloadUrl);
        _isUploading = false;
      });
    }

    LoadingOverlay().hide();
  }

  void _deleteImage(int vehicleIndex, int imageIndex) {
    setState(() {
      _imageUrls[vehicleIndex].removeAt(imageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Vehicles",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Number of Vehicles $_numberOfVehicles',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
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
              onPressed: _isUploading ? null : _addVehicle,
              child: Text(
                'Add Vehicle',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 24.0),
            Expanded(
              child: ListView.builder(
                itemCount: _numberOfVehicles,
                itemBuilder: (context, vehicleIndex) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Vehicle ${vehicleIndex + 1}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Name & Model',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 6.0),
                      TextField(
                        controller: _vehicleControllers[vehicleIndex],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8.0),
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
                              vertical:
                                  6), // Adjust the padding as per your requirement
                        ),
                        onPressed:
                            _isUploading ? null : () => _getImage(vehicleIndex),
                        child: Text(
                          'Upload Images',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Divider(),
                      SizedBox(height: 16.0),
                      // Display selected images and delete option
                      if (_imageUrls[vehicleIndex].isNotEmpty) ...[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              _imageUrls[vehicleIndex].length,
                              (imageIndex) {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CommonImageView(
                                        url: _imageUrls[vehicleIndex]
                                            [imageIndex],
                                        height: 150,
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: _isUploading
                                            ? null
                                            : () => _deleteImage(
                                                vehicleIndex, imageIndex),
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
            SubmitButton(
                onTap: () {
                  List<Map> vehicles = [];
                  for (int i = 0; i < _imageUrls.length; i++) {
                    vehicles.add({
                      "model": _vehicleControllers[i].text.trim(),
                      "images": _imageUrls[i]
                    });
                  }
                  context.read<VerifyAccountBloc>().add(UpdateVehiclesEvent(
                      vehicles: vehicles, context: context));
                },
                lable: "Save"),
          ],
        ),
      ),
    );
  }
}
