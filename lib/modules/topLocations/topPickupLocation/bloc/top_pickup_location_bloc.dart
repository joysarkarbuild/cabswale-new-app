import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/topLocations/topPickupLocation/bloc/top_pickup_location_event.dart';
import 'package:cabswalle/modules/topLocations/topPickupLocation/bloc/top_pickup_location_state.dart';
import 'package:cabswalle/modules/topLocations/topPickupLocation/data/models/top_pickup_location_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TopPickupLocationBloc
    extends Bloc<TopPickupLocationEvent, TopPickupLocationState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<TopPickupModel> _routes = [];
  int _currentPage = 0;
  bool _hasMoreData = true;
  String _currentCollection = 'monthlyPagination';

  TopPickupLocationBloc() : super(TopPickupLocationInitial()) {
    on<FetchTopPickupLocation>(_onFetchRoutes);
    on<ResetTopPickupLocation>(_onResetRoutes);
    on<LoadMorePickupLocations>(_onLoadMoreRoutes);
  }

  Future<void> _onFetchRoutes(FetchTopPickupLocation event,
      Emitter<TopPickupLocationState> emit) async {
    if (state is TopPickupLocationLoading) return;
    if (event.showLoading) {
      emit(TopPickupLocationLoading());
    } else {
      emit(TopPickupLocationLoaded(
          topPickupLocations: _routes,
          hasMore: _hasMoreData,
          isMoreLoading: true));
    }
    try {
      final doc = await firestore
          .collection("analytics")
          .doc(event.isDrop ? "dropCities" : "pickupCities")
          .collection(event.collection)
          .doc(event.page.toString())
          .get();

      final List data = doc.data()?["data"] ?? [];
      if (data.isEmpty) {
        _hasMoreData = false;
      } else {
        final routes = data.map((e) => TopPickupModel.fromJson(e)).toList();
        if (event.page == 0) {
          _routes = routes;
        } else {
          _routes.addAll(routes);
        }
      }

      emit(TopPickupLocationLoaded(
          topPickupLocations: _routes,
          hasMore: _hasMoreData,
          isMoreLoading: false));
    } catch (e) {
      emit(TopPickupLocationError(e.toString()));
    }
  }

  void _onResetRoutes(
      ResetTopPickupLocation event, Emitter<TopPickupLocationState> emit) {
    _routes = [];
    _currentPage = 0;
    _hasMoreData = true;
    _currentCollection = event.collection;
    add(FetchTopPickupLocation(0, event.collection, true, event.isDrop));
  }

  void _onLoadMoreRoutes(
      LoadMorePickupLocations event, Emitter<TopPickupLocationState> emit) {
    if (_hasMoreData) {
      _currentPage++;
      add(FetchTopPickupLocation(
          _currentPage, _currentCollection, false, event.isDrop));
    }
  }
}
