import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/community/bloc/community_event.dart';
import 'package:cabswalle/modules/community/bloc/community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  CommunityBloc() : super(CommunityInitial()) {
    on<CommunityEvent>((event, emit) {});
  }
}
