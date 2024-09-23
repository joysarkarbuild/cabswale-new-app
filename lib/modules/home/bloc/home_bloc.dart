import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/home/bloc/home_event.dart';
import 'package:cabswalle/modules/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
  }
}
