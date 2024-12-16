import 'package:cabswalle/modules/home/data/models/count_data_model.dart';
import 'package:cabswalle/modules/myprofile/data/models/user_profile_data_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class FetchHomeDataEvent extends HomeEvent {
  const FetchHomeDataEvent();

  @override
  List<Object> get props => [];
}

final class ChangeLeadType extends HomeEvent {
  final String leadType;
  final CountDataModel countData;
  const ChangeLeadType({required this.leadType, required this.countData});
  @override
  List<Object> get props => [leadType, countData];
}

final class FetchMoreLeadsEvent extends HomeEvent {
  final int pageNo;
  const FetchMoreLeadsEvent({required this.pageNo});
  @override
  List<Object> get props => [pageNo];
}

final class SearchLeads extends HomeEvent {
  final String searcText;
  final CountDataModel countData;
  const SearchLeads({required this.searcText, required this.countData});
  @override
  List<Object> get props => [searcText, countData];
}

final class UpdateNotificationLocationsEvent extends HomeEvent {
  const UpdateNotificationLocationsEvent();

  @override
  List<Object> get props => [];
}

final class UpdateGetDutyAlertEvent extends HomeEvent {
  final BuildContext context;
  final bool isActive;
  const UpdateGetDutyAlertEvent(
      {required this.context, required this.isActive});

  @override
  List<Object> get props => [isActive];
}
