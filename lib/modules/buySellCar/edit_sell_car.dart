import 'dart:io';
import 'package:cabswalle/modules/buySellCar/data/models/car_model.dart';
import 'package:cabswalle/modules/buySellCar/my_listing.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class EditCarScreen extends StatefulWidget {
  final CarModel car;

  const EditCarScreen({super.key, required this.car});

  @override
  State<EditCarScreen> createState() => _EditCarScreenState();
}

class _EditCarScreenState extends State<EditCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final List<File> _localImages = [];
  final List<String> _uploadedImageUrls = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _modelController.text = widget.car.model;
    _detailsController.text = widget.car.details;
    _locationController.text = widget.car.location;
    _priceController.text = widget.car.price.toString();
    _yearController.text = widget.car.year;
    _uploadedImageUrls.addAll(widget.car.images);
  }

  @override
  void dispose() {
    _modelController.dispose();
    _detailsController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  static Future<File?> _compressImage(File file, int targetSizeInBytes) async {
    int quality = 90;
    File? compressedFile;

    while (true) {
      final tempDir = await getTemporaryDirectory();
      String targetPath = path.join(
        tempDir.path,
        "${path.basenameWithoutExtension(file.path)}.jpg",
      );

      XFile? temp = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
        format: CompressFormat.jpeg,
      );

      if (temp == null) return null;
      compressedFile = File(temp.path);

      if (compressedFile.lengthSync() <= targetSizeInBytes) {
        break;
      }

      quality -= 10;
      if (quality < 10) {
        break;
      }
    }

    return compressedFile;
  }

  Future<String> _uploadSingleImage(File file) async {
    final storageRef =
        FirebaseStorage.instance.ref().child('car_images/${const Uuid().v4()}');
    final compressFile = await _compressImage(file, 300000);

    final snapshot = await storageRef.putFile(compressFile!);
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if ((_localImages.length + _uploadedImageUrls.length) == 5) {
      SnackbarUtils.showErrorSnackBar(
          message: "Maximum 5 images can be added!");
      return;
    }
    if (pickedFile != null) {
      setState(() {
        _localImages.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      if (index < _uploadedImageUrls.length) {
        _uploadedImageUrls.removeAt(index);
      } else {
        _localImages.removeAt(index - _uploadedImageUrls.length);
      }
    });
  }

  Future<void> _updateCarInFirestore() async {
    if (_formKey.currentState!.validate()) {
      if (_uploadedImageUrls.isEmpty && _localImages.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload at least one image!')),
        );
        return;
      }

      setState(() {
        _isSaving = true;
      });

      try {
        // Upload new images and collect their URLs
        for (File file in _localImages) {
          final url = await _uploadSingleImage(file);
          _uploadedImageUrls.add(url);
        }

        final updatedCar = {
          'model': _modelController.text,
          'details': _detailsController.text,
          'location': _locationController.text,
          'price': int.parse(_priceController.text),
          'year': _yearController.text,
          'images': _uploadedImageUrls,
          'updatedAt': Timestamp.now(),
        };

        await FirebaseFirestore.instance
            .collection('carDeals')
            .doc(widget.car.id)
            .update(updatedCar);

        SnackbarUtils.showSuccessSnackBar(message: 'Car updated successfully!');
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => MyListingScreen(),
            ));
      } catch (e) {
        SnackbarUtils.showErrorSnackBar(message: 'Failed to update car: $e');
      } finally {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Car'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                _buildTextField(
                  controller: _modelController,
                  label: 'Model',
                  hint: 'Enter car model',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _detailsController,
                  decoration: const InputDecoration(
                    labelText: 'Details',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the details';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _locationController,
                  label: 'Location',
                  hint: 'Enter location',
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _priceController,
                  label: 'Price',
                  hint: 'Enter price',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _yearController,
                  label: 'Year',
                  hint: 'Enter year',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Text(
                  'Images (${_uploadedImageUrls.length + _localImages.length} selected)',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ..._uploadedImageUrls.asMap().entries.map(
                          (entry) => Stack(
                            children: [
                              Image.network(
                                entry.value,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => _removeImage(entry.key),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ..._localImages.asMap().entries.map(
                          (entry) => Stack(
                            children: [
                              Image.file(
                                entry.value,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => _removeImage(
                                      entry.key + _uploadedImageUrls.length),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text('Select Images'),
                ),
                const SizedBox(height: 16),
                SubmitButton(
                  onTap: _updateCarInFirestore,
                  lable: "Save",
                  borderRadius: 5,
                  loading: _isSaving,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
    );
  }
}