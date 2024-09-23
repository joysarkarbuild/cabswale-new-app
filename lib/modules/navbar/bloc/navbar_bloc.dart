import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/navbar/bloc/navbar_event.dart';
import 'package:cabswalle/modules/navbar/bloc/navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(const NavbarState(0)) {
    on<ChangeTab>((event, emit) {
      emit(NavbarState(event.newIndex));
    });
  }
}
