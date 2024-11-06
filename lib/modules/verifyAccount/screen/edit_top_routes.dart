import 'package:cabswalle/modules/myprofile/bloc/myprofile_bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_state.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_bloc.dart';
import 'package:cabswalle/modules/verifyAccount/bloc/verify_account_event.dart';
import 'package:cabswalle/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditTopRoutes extends StatelessWidget {
  const EditTopRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, TextEditingController>> routes = List.generate(
        5,
        (index) => {
              "from": TextEditingController(text: ""),
              "to": TextEditingController(text: "")
            });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Top 5 Routes",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<MyprofileBloc, MyprofileState>(
                builder: (context, state) {
                  if (state is MyProfileLoaded) {
                    List topRoutes = state.myProfile.routes ?? [];
                    for (int i = 0; i < topRoutes.length; i++) {
                      routes[i]["from"]!.text = topRoutes[i]["from"];
                      routes[i]["to"]!.text = topRoutes[i]["to"];
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(5, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Route ${index + 1}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: routes[index]["from"],
                                    decoration: InputDecoration(
                                      labelText: 'Pickup',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Icon(Icons.arrow_forward, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: TextField(
                                    controller: routes[index]["to"],
                                    decoration: InputDecoration(
                                      labelText: 'Drop',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                          ],
                        );
                      }),
                    );
                  } else {
                    return Text("Something went wrong");
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              SubmitButton(
                onTap: () {
                  List<Map<String, String>> st = [];
                  for (Map<String, TextEditingController> et in routes) {
                    if (et["from"]!.text.isNotEmpty) {
                      st.add({
                        "from": et["from"]!.text.trim(),
                        "to": et["to"]!.text.trim()
                      });
                    }
                  }
                  if (st.isNotEmpty) {
                    context.read<VerifyAccountBloc>().add(
                        UpdateTopRoutesEvent(topRoutes: st, context: context));
                  } else {
                    context.pop();
                  }
                },
                lable: "Save",
                borderRadius: 6,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
