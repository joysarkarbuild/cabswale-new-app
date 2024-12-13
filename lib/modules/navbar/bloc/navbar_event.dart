import 'package:equatable/equatable.dart';

sealed class NavbarEvent extends Equatable {
  const NavbarEvent();

  @override
  List<Object> get props => [];
}

class ChangeTab extends NavbarEvent {
  final int newIndex;

  const ChangeTab(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}
