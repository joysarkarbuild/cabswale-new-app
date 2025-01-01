import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/language/bloc/language_event.dart';
import 'package:cabswalle/modules/language/bloc/language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial(local: "en")) {
    on<ChangeLanguageEvent>((event, emit) {
      emit(LanguageInitial(local: event.local));
    });
  }
}
