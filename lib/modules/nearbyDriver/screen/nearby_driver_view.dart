import 'package:cabswalle/modules/nearbyDriver/bloc/nearby_driver_bloc.dart';
import 'package:cabswalle/modules/nearbyDriver/bloc/nearby_driver_event.dart';
import 'package:cabswalle/modules/nearbyDriver/bloc/nearby_driver_state.dart';
import 'package:cabswalle/widgets/centre_loading.dart';
import 'package:cabswalle/widgets/nearby_driver_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyDriverScreen extends StatelessWidget {
  const NearbyDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<NearbyDriverBloc>().add(FetchNearbyDriver());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nearby Drivers",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<NearbyDriverBloc, NearbyDriverState>(
        builder: (context, state) {
          if (state is NearbyDriverLoading) {
            return CentreLoading();
          }
          if (state is NearbyDriverLoaded) {
            return SafeArea(
              child: state.nearbyDrivers.isEmpty
                  ? const Center(
                      child: Text(
                        "No nearby drivers available",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: ListView.builder(
                        itemCount: state.nearbyDrivers.length - 1,
                        itemBuilder: (context, index) {
                          var driver = state.nearbyDrivers[index + 1];
                          return Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 5),
                            child: NearbyDriversCard(
                              verifiedDriver: driver,
                            ),
                          );
                        },
                      ),
                    ),
            );
          }
          if (state is NearbyDriverError) {
            return Center(
              child: Text(state.meaasge),
            );
          } else {
            return Center(
              child: Text("Something went Wrong!"),
            );
          }
        },
      ),
    );
  }
}
