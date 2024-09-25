import 'package:cabswalle/services/snackbar_service.dart';
import 'package:flutter/material.dart';

class CityPreferencesScreen extends StatefulWidget {
  const CityPreferencesScreen({super.key});

  @override
  State<CityPreferencesScreen> createState() => _CityPreferencesScreenState();
}

class _CityPreferencesScreenState extends State<CityPreferencesScreen> {
  bool isSubmitted = false;
  bool notificationAlert = false;
  List<TextEditingController> cityPreferences = [
    TextEditingController(text: ""),
    TextEditingController(text: ""),
    TextEditingController(text: ""),
    TextEditingController(text: ""),
    TextEditingController(text: "")
  ]; // List to store city preferences

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Duty Alerts'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 40,
              child: FittedBox(
                child: Switch(
                  value: notificationAlert,
                  onChanged: (val) {},
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                '*Add up to 5 locations for duties alerts',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location ${i + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: cityPreferences[i],
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 8, top: 2, bottom: 2),
                          border: OutlineInputBorder(),
                          hintText: 'Enter location name',
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Do something with cityPreferences list when submit button is pressed

                  List<String> notiLoc = [];
                  for (TextEditingController city in cityPreferences) {
                    if (city.text.isNotEmpty) {
                      notiLoc.add(city.text.trim());
                    }
                  }

                  if (notiLoc.isEmpty) {
                    SnackbarUtils.showErrorSnackBar(
                        message: 'Add at least 1 location');
                    return;
                  }
                  setState(() {
                    isSubmitted = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  minimumSize: Size(
                    MediaQuery.of(context).size.width,
                    40,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
                child: isSubmitted
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
              ),
              TextButton(
                onPressed: () async {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Clear Cities",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Icon(
                        Icons.close,
                        color: Colors.blue,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
