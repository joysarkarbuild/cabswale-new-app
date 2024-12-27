import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/topLocations/topRoutes/data/models/top_routes_model.dart';
import 'package:cabswalle/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'top_routes_event.dart';
import 'top_routes_state.dart';

class TopRoutesBloc extends Bloc<TopRoutesEvent, TopRoutesState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<TopRouteModel> _routes = [];
  int _currentPage = 0;
  bool _hasMoreData = true;
  String _currentCollection = 'monthlyPagination';

  TopRoutesBloc() : super(TopRoutesInitial()) {
    on<FetchRoutes>(_onFetchRoutes);
    on<ResetRoutes>(_onResetRoutes);
    on<LoadMoreRoutes>(_onLoadMoreRoutes);
  }

  Future<void> _onFetchRoutes(
      FetchRoutes event, Emitter<TopRoutesState> emit) async {
    if (state is TopRoutesLoading) return;
    if (event.showLoading) {
      emit(TopRoutesLoading());
    } else {
      emit(TopRoutesLoaded(
          routes: _routes, hasMore: _hasMoreData, isMoreLoading: true));
    }

    try {
      final doc = await firestore
          .collection("analytics")
          .doc("routes")
          .collection(event.collection)
          .doc(event.page.toString())
          .get();
      LoggerService.logInfo("data called");

      final List data = doc.data()?["data"] ?? [];
      if (data.isEmpty) {
        _hasMoreData = false;
      } else {
        final routes = data.map((e) => TopRouteModel.fromJson(e)).toList();
        if (event.page == 0) {
          _routes = routes;
        } else {
          _routes.addAll(routes);
        }
      }

      emit(TopRoutesLoaded(
          routes: _routes, hasMore: _hasMoreData, isMoreLoading: false));
    } catch (e) {
      emit(TopRoutesError(e.toString()));
    }
  }

  void _onResetRoutes(ResetRoutes event, Emitter<TopRoutesState> emit) {
    _routes = [];
    _currentPage = 0;
    _hasMoreData = true;
    _currentCollection = event.collection;
    add(FetchRoutes(0, event.collection, true));
  }

  void _onLoadMoreRoutes(LoadMoreRoutes event, Emitter<TopRoutesState> emit) {
    if (_hasMoreData) {
      _currentPage++;
      add(FetchRoutes(_currentPage, _currentCollection, false));
    }
  }
}
