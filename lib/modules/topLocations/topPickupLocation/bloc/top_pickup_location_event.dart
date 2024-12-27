import 'package:equatable/equatable.dart';

abstract class TopPickupLocationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTopPickupLocation extends TopPickupLocationEvent {
  final int page;
  final String collection;
  final bool showLoading;
  final bool isDrop;

  FetchTopPickupLocation(
      this.page, this.collection, this.showLoading, this.isDrop);

  @override
  List<Object?> get props => [page, collection, showLoading, isDrop];
}

class ResetTopPickupLocation extends TopPickupLocationEvent {
  final String collection;
  final bool isDrop;

  ResetTopPickupLocation(this.collection, this.isDrop);

  @override
  List<Object?> get props => [collection, isDrop];
}

class LoadMorePickupLocations extends TopPickupLocationEvent {
  final bool isDrop;
  LoadMorePickupLocations(this.isDrop);
  @override
  List<Object?> get props => [isDrop];
}
