import 'package:equatable/equatable.dart';

sealed class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

final class LanguageInitial extends LanguageState {
  final String local;

  const LanguageInitial({required this.local});
  @override
  List<Object> get props => [local];
}
