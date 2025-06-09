import 'package:common/auth/repository/repository.dart';
import 'package:common/http/http_client.dart';
import 'package:fiacto/authenticatorActivation/cubit/authenticator_activation_cubit.dart';
import 'package:fiacto/authenticatorActivation/repository/authenticator_repo_impl.dart';
import 'package:fiacto/authenticatorActivation/view/authenticator_activation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticatorActivationPage extends StatelessWidget {
  const AuthenticatorActivationPage({super.key});

  static String route() => '/authenticator_activation';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => AuthenticatorActivationCubit(
            id: context.read<AuthRepository>().currentUser.id,
            repository: AuthenticatorRepoImpl(
              httpClient: context.read<HttpClient>(),
            ),
          )..getQRCodeImage(),
      // ..getSecretKey(),
      child: const AuthenticatorActivationView(),
    );
  }
}
