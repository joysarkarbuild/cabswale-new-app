import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/cityPreferences/bloc/city_preferences_event.dart';
import 'package:cabswalle/modules/cityPreferences/bloc/city_preferences_state.dart';

class CityPreferencesBloc
    extends Bloc<CityPreferencesEvent, CityPreferencesState> {
  CityPreferencesBloc() : super(CityPreferencesInitial()) {
    on<CityPreferencesEvent>((event, emit) {});
  }
}
