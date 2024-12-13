import 'package:equatable/equatable.dart';

sealed class PartnerWithUsState extends Equatable {
  const PartnerWithUsState();

  @override
  List<Object> get props => [];
}

final class PartnerWithUsInitial extends PartnerWithUsState {}
