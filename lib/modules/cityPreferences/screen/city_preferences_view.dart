import 'package:cabswalle/modules/home/bloc/home_bloc.dart';
import 'package:cabswalle/modules/home/bloc/home_event.dart';
import 'package:cabswalle/modules/home/bloc/home_state.dart';
import 'package:cabswalle/services/driver_service.dart';
import 'package:cabswalle/services/loading_overlay_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
                        value: state.userProfile != null
                            ? state.userProfile!.notificationAlert!
                            : false,
                        onChanged: (val) async {
                          context
                              .read<HomeBloc>()
                              .add(UpdateNotificationLocationsEvent());
                          await DriverService.instance
                              .updateDriverField("notificationAlert", val);
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
                if (state.userProfile != null &&
                    state.userProfile!.notificationLocations != null) {
                  for (int i = 0;
                      i < state.userProfile!.notificationLocations!.length;
                      i++) {
                    cityPreferences[i].text =
                        state.userProfile!.notificationLocations![i];
                  }
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
                      } else {
                        LoadingOverlay().show(context);
                        context
                            .read<HomeBloc>()
                            .add(UpdateNotificationLocationsEvent());
                        await DriverService.instance.updateDriverField(
                            "notificationLocations", notiLoc);
                        LoadingOverlay().hide();
                        // ignore: use_build_context_synchronously
                        context.pop();
                      }
                    },
                    lable: "Submit",
                  ),
                  TextButton(
                    onPressed: () {
                      for (int i = 0; i < 5; i++) {
                        cityPreferences[i].text = "";
                      }
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
