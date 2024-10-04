import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/videosFromRealDrivers/bloc/videosFromRealDrivers_event.dart';
import 'package:cabswalle/modules/videosFromRealDrivers/bloc/videosFromRealDrivers_state.dart';

class VideosFromRealDriversBloc extends Bloc<VideosFromRealDriversEvent, VideosFromRealDriversState> {
  VideosFromRealDriversBloc() : super(VideosFromRealDriversInitial()) {
    on<VideosFromRealDriversEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
