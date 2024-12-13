import 'package:equatable/equatable.dart';

sealed class CityPreferencesState extends Equatable {
  const CityPreferencesState();

  @override
  List<Object> get props => [];
}

final class CityPreferencesInitial extends CityPreferencesState {}
