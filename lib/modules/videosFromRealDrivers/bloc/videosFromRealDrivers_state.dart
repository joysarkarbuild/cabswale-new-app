import 'package:equatable/equatable.dart';

sealed class VideosFromRealDriversState extends Equatable {
  const VideosFromRealDriversState();

  @override
  List<Object> get props => [];
}

final class VideosFromRealDriversInitial extends VideosFromRealDriversState {}
