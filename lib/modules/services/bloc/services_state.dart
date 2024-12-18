import 'package:equatable/equatable.dart';

sealed class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object?> get props => [];
}

final class ServicesInitial extends ServicesState {}

final class ServicesLoading extends ServicesState {}

final class ServicesLoaded extends ServicesState {
  final Map<String, dynamic> community;
  final int walletBalance;

  const ServicesLoaded(
    this.community,
    this.walletBalance,
  );

  @override
  List<Object?> get props => [
        community,
        walletBalance,
      ];
}

final class ServicesError extends ServicesState {
  final String message;

  const ServicesError(this.message);

  @override
  List<Object?> get props => [message];
}
