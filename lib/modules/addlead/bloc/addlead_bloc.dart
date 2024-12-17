import 'package:cabswalle/modules/addlead/bloc/addlead_event.dart';
import 'package:cabswalle/modules/addlead/bloc/addlead_state.dart';
import 'package:cabswalle/modules/addlead/data/repository/add_lead_data_repository.dart';
import 'package:cabswalle/modules/myleads/bloc/myleads_bloc.dart';
import 'package:cabswalle/modules/myleads/bloc/myleads_event.dart';
import 'package:cabswalle/services/loading_overlay_service.dart';
import 'package:cabswalle/services/snackbar_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddleadBloc extends Bloc<AddleadEvent, AddleadState> {
  AddleadBloc() : super(AddleadInitial()) {
    AddLeadDataRepository addLeadDataRepository = AddLeadDataRepository();
    on<ChangeLeadTypeEvent>((event, emit) {
      emit(ChangeLeadType(leadType: event.leadType));
    });
    on<UploadLeadEvent>(
      (event, emit) async {
        try {
          LoadingOverlay().show(event.context);
          bool status = await addLeadDataRepository.addLead(
              pickupLocation: event.pickupLocation,
              dropLocation: event.dropLocation,
              vehicle: event.vehicle,
              leadType: (state as ChangeLeadType).leadType,
              extraMessage: event.extraMessage);
          if (status) {
            SnackbarUtils.showSuccessSnackBar(message: "Lead Added");
            // ignore: use_build_context_synchronously
            event.context.pop();
            // ignore: use_build_context_synchronously
            event.context.read<MyleadsBloc>().add(FetchMyLeads());
          } else {
            SnackbarUtils.showErrorSnackBar(message: "Failed to add lead!");
          }
          LoadingOverlay().hide();
        } catch (e) {
          SnackbarUtils.showErrorSnackBar(message: e.toString());
        }
      },
    );
  }
}
