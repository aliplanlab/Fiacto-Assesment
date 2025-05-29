import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:common/auth/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required this.authRepository,
  }) : super(AppState(user: authRepository.currentUser)) {
    on<_AppUserChanged>(_onAppUserChanged);
    on<AppUserLogout>(_onAppUserLogout);
    _userSubscription = authRepository.user.listen(
      (user) async {
        if (!state.user.isLoading) {
          add(_AppUserChanged(user));
          return;
        }
        await Future<void>.delayed(const Duration(seconds: 3));
        add(_AppUserChanged(user));
      },
    );
  }

  final AuthRepository authRepository;
  late final StreamSubscription<User> _userSubscription;

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    await authRepository.dispose();
    return super.close();
  }

  void _onAppUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(user: event.user));
  }

  void _onAppUserLogout(AppUserLogout event, Emitter<AppState> emit) {
    authRepository.logOut();
  } 
}
