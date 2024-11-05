import 'package:equatable/equatable.dart';

sealed class AddleadEvent extends Equatable {
  const AddleadEvent();

  @override
  List<Object> get props => [];
}

final class ChangeLeadTypeEvent extends AddleadEvent {
  final String leadType;
  const ChangeLeadTypeEvent({required this.leadType});
  @override
  List<Object> get props => [leadType];
}
