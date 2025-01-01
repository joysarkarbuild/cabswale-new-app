import 'package:equatable/equatable.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

final class ChangeLanguageEvent extends LanguageEvent {
  final String local;

  const ChangeLanguageEvent({required this.local});

  @override
  List<Object> get props => [local];
}
