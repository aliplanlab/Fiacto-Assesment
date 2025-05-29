part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class AppUserLogout extends AppEvent {}

class AppOnboarded extends AppEvent {}
