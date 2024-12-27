import 'package:equatable/equatable.dart';

abstract class TopRoutesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRoutes extends TopRoutesEvent {
  final int page;
  final String collection;
  final bool showLoading;

  FetchRoutes(this.page, this.collection, this.showLoading);

  @override
  List<Object?> get props => [page, collection, showLoading];
}

class ResetRoutes extends TopRoutesEvent {
  final String collection;

  ResetRoutes(this.collection);

  @override
  List<Object?> get props => [collection];
}

class LoadMoreRoutes extends TopRoutesEvent {}
