import 'package:common/common.dart';
import 'package:common/widgets/custom_alert_dialog.dart';
import 'package:fiacto/accountVerification/cubit/twoFactor_login_cubit.dart';
import 'package:fiacto/accountVerification/repository/two_factor_login_repo_impl.dart';
import 'package:fiacto/auth/auth_cubit/auth_cubit.dart';
import 'package:fiacto/widgets/custom_pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginAuthenticatorVerificationPage extends StatelessWidget {
  const LoginAuthenticatorVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => TwoFaLoginCubit(
            repository: TwoFactorLoginRepoImpl(
              httpClient: context.read<HttpClient>(),
            ),
            auth: context.read<AuthCubit>(),
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Enter the 6-Digit Code',
              style: context.twenty600.withColor(Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter the code from your app',
              style: context.fourteen400.withColor(context.grey500),
            ),
            const SizedBox(height: 24),
            _AuthCodeField(),
            const SizedBox(height: 24),
            Text(
              'The code refreshes every 30 seconds',
              style: context.fourteen400.withColor(context.grey500),
            ),
            const SizedBox(height: 24),
            _VerifyAndEnableButton(),
          ],
        ),
      ),
    );
  }
}

class _AuthCodeField extends StatelessWidget {
  const _AuthCodeField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TwoFaLoginCubit, TwoFaLoginState>(
      buildWhen:
          (previous, current) =>
              previous.authAppCode != current.authAppCode ||
              previous.status != current.status,
      builder: (context, state) {
        return CustomPinputWidget(
          length: 6,
          onChanged: (p0) {
            context.read<TwoFaLoginCubit>().updateAuthenticatorCode(p0);
          },
        );
      },
    );
  }
}

class _VerifyAndEnableButton extends StatelessWidget {
  const _VerifyAndEnableButton();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        //If Code verified then We update the MFA status to authenticator
        BlocListener<TwoFaLoginCubit, TwoFaLoginState>(
          listenWhen:
              (previous, current) =>
                  previous.verifyLoginAuthenticatorDataState !=
                  current.verifyLoginAuthenticatorDataState,
          listener: (context, state) {
            if (state.verifyLoginAuthenticatorDataState.isFailure) {
              context.errorSnackbar(
                state.verifyLoginAuthenticatorDataState.errorMessage,
              );
            } else if (state.verifyLoginAuthenticatorDataState.isLoaded) {
              // context.read<AuthenticatorActivationCubit>().updateMFAStatus();
            }
          },
        ),
        BlocListener<TwoFaLoginCubit, TwoFaLoginState>(
          listenWhen:
              (previous, current) =>
                  previous.builderUpdateDataState !=
                  current.builderUpdateDataState,
          listener: (context, state) {
            if (state.builderUpdateDataState.isFailure) {
              context.errorSnackbar(state.builderUpdateDataState.errorMessage);
            } else if (state.builderUpdateDataState.isLoaded) {
              context.read<AuthCubit>().getUserBuilder();
            }
          },
        ),
        BlocListener<AuthCubit, AuthState>(
          listenWhen:
              (previous, current) =>
                  previous.getUserDataState != current.getUserDataState,
          listener: (context, state) async {
            if (state.getUserDataState.isFailure) {
              context.errorSnackbar(state.getUserDataState.errorMessage);
            } else if (state.getUserDataState.isLoaded) {
              final data =
                  context.read<AuthCubit>().state.getUserDataState.data;
              if (data == null) return;

              showDialog<CustomAlertDialog>(
                context: context,
                builder:
                    (context) => const CustomAlertDialog(
                      title: '2F Authentication Activated!',
                      subTitle:
                          'Your setup is complete. Use your Google Authenticator app to generate OTP.',
                    ),
              );
              await Future<void>.delayed(const Duration(seconds: 3));
              if (!context.mounted) return;
              Navigator.pop(context);
              final token = context.read<AuthRepository>().currentUser.token;
              context.read<AuthRepository>().updateUser(
                User.fromEntity(data, token),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<TwoFaLoginCubit, TwoFaLoginState>(
        buildWhen:
            (previous, current) =>
                previous.status != current.status ||
                previous.verifyLoginAuthenticatorDataState !=
                    current.verifyLoginAuthenticatorDataState ||
                previous.authAppCode != current.authAppCode,
        builder: (context, state) {
          return CustomElevatedButton.expanded(
            text: 'Verify & Enable 2FA',
            enabled: state.authAppCode.value.length == 6,
            loading: state.verifyLoginAuthenticatorDataState.isLoading,
            onPressed: () {
              context.read<TwoFaLoginCubit>().verifyAuthenticatorAppCode();
            },
          );
        },
      ),
    );
  }
}
