part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({this.user = User.loading, this.splashDone = false});

  final User user;
  final bool splashDone;

  AppState copyWith({User? user, bool? onboarded, bool? splashDone}) {
    return AppState(
      user: user ?? this.user,
      splashDone: splashDone ?? this.splashDone,
    );
  }

  @override
  List<Object?> get props => [user, splashDone];
}

extension AppStateValues on AppState {
  bool get isAuthenticated => user.isAuthenticated;

  bool get isNotAuthenticated => user.isNotAuthenticated;

  bool get isLoading => user.isLoading;
}
