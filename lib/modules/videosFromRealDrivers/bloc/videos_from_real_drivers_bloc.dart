import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/videosFromRealDrivers/bloc/videos_from_real_drivers_event.dart';
import 'package:cabswalle/modules/videosFromRealDrivers/bloc/videos_from_real_drivers_state.dart';

class VideosFromRealDriversBloc
    extends Bloc<VideosFromRealDriversEvent, VideosFromRealDriversState> {
  VideosFromRealDriversBloc() : super(VideosFromRealDriversInitial()) {
    on<VideosFromRealDriversEvent>((event, emit) {});
  }
}
