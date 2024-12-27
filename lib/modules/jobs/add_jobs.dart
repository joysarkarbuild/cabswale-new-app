import 'package:cabswalle/modules/jobs/data/models/job_model.dart';
import 'package:cabswalle/modules/jobs/my_jobs_screen.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key, required this.isMain});
  final bool isMain;

  @override
  // ignore: library_private_types_in_public_api
  _AddJobScreenState createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  Future<void> _addJob() async {
    if (_formKey.currentState!.validate()) {
      // Create a JobModel instance without the ID
      final job = JobModel(
        id: '', // We'll update this with the generated doc ID
        active: true,
        createdAt: DateTime.now(),
        details: _detailsController.text.trim(),
        location: _locationController.text.trim(),
        phoneNo: DriverService.instance.driverModel!.phoneNo,
        uid: DriverService.instance.driverModel!.id,
        isVerified: false,
      );

      // Save the job to Firestore and get the document ID
      try {
        // Add the job to Firestore and get the document reference
        await FirebaseFirestore.instance.collection('jobs').add(job.toJson());

        SnackbarUtils.showSuccessSnackBar(message: 'Job added successfully!');

        // Reset form fields
        _formKey.currentState?.reset();
        _locationController.clear();
        _detailsController.clear();

        // Navigate back
        // ignore: use_build_context_synchronously
        if (widget.isMain) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => const MyJobsScreen(),
            ));
      } catch (e) {
        // Show error message
        // ignore: use_build_context_synchronously
        SnackbarUtils.showSuccessSnackBar(message: 'Failed to add job: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Job'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true, // Align label with hint text
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                textAlignVertical:
                    TextAlignVertical.top, // Ensure alignment at the top
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Spacer(),
              SubmitButton(
                onTap: _addJob,
                lable: "Add Job",
                borderRadius: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
