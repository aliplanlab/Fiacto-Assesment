import 'package:fiacto/authenticatorActivation/cubit/authenticator_activation_cubit.dart';
import 'package:fiacto/authenticatorActivation/view/authenticator_activation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticatorActivationPage extends StatelessWidget {
  const AuthenticatorActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticatorActivationCubit(),
      child: const AuthenticatorActivationView(),
    );
  }
}
