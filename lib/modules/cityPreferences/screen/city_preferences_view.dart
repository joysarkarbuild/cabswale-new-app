import 'package:cabswalle/modules/home/bloc/home_bloc.dart';
import 'package:cabswalle/modules/home/bloc/home_event.dart';
import 'package:cabswalle/modules/home/bloc/home_state.dart';
import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityPreferencesScreen extends StatefulWidget {
  const CityPreferencesScreen({super.key});

  @override
  State<CityPreferencesScreen> createState() => _CityPreferencesScreenState();
}

class _CityPreferencesScreenState extends State<CityPreferencesScreen> {
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
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadedState) {
                      return Switch(
                        value: false,
                        onChanged: (val) {
                          context.read<HomeBloc>().add(UpdateGetDutyAlertEvent(
                              context: context, isActive: val));
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadedState) {
                for (int i = 0; i < 0; i++) {
                  cityPreferences[i].text = "";
                }
              }
              return Column(
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
                  SubmitButton(
                    onTap: () async {
                      // Do something with cityPreferences list when submit button is pressed

                      List<NotificationLocation> notiLoc = [];
                      for (TextEditingController city in cityPreferences) {
                        if (city.text.isNotEmpty) {
                          notiLoc.add(
                              NotificationLocation(location: city.text.trim()));
                        }
                      }

                      if (notiLoc.isEmpty) {
                        SnackbarUtils.showErrorSnackBar(
                            message: 'Add at least 1 location');
                        return;
                      } else {
                        context.read<HomeBloc>().add(
                            UpdateNotificationLocationsEvent(
                                context: context,
                                notificationLocations: notiLoc));
                      }
                    },
                    lable: "Submit",
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(
                          UpdateNotificationLocationsEvent(
                              context: context, notificationLocations: []));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Icon(
                            Icons.close,
                            color: Colors.blue,
                            size: 18,
                          ),
                        ),
                        Text(
                          "Clear Cities",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
