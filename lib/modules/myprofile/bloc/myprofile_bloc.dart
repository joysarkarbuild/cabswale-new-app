import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_event.dart';
import 'package:cabswalle/modules/myprofile/bloc/myprofile_state.dart';

class MyprofileBloc extends Bloc<MyprofileEvent, MyprofileState> {
  MyprofileBloc() : super(MyprofileInitial()) {
    on<MyprofileEvent>((event, emit) {});
  }
}
