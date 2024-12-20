import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/deals/bloc/deals_event.dart';
import 'package:cabswalle/modules/deals/bloc/deals_state.dart';
import 'package:cabswalle/modules/deals/data/repository/deals_data_repository.dart';

class DealsBloc extends Bloc<DealsEvent, DealsState> {
  DealsBloc() : super(DealsInitial()) {
    DealsDataRepository dealsDataRepository = DealsDataRepository();
    on<DealsEvent>((event, emit) {});
    on<FetchDealsData>(
      (event, emit) async {
        emit(DealsLoading());

        Map<String, dynamic> dealsData =
            await dealsDataRepository.getCallAnalytics();
        emit(DealsLoaded(data: dealsData));
      },
    );
  }
}
