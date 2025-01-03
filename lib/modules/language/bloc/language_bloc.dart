import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/language/bloc/language_event.dart';
import 'package:cabswalle/modules/language/bloc/language_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial(local: "en")) {
    _loadLanguagePreference();
    on<ChangeLanguageEvent>((event, emit) {
      _saveLanguagePreference(event.local);
      emit(LanguageInitial(local: event.local));
    });
  }

  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final local =
        prefs.getString('selected_language') ?? 'en'; // Default to "en"
    add(ChangeLanguageEvent(local: local)); // Add an event to update the state
  }

  Future<void> _saveLanguagePreference(String local) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', local);
  }
}
