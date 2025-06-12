import 'package:common/common.dart';
import 'package:common/widgets/custom_alert_dialog.dart';
import 'package:fiacto/accountVerification/cubit/twoFactor_login_cubit.dart';
import 'package:fiacto/accountVerification/repository/two_factor_login_repo_impl.dart';
import 'package:fiacto/auth/auth_cubit/auth_cubit.dart';
import 'package:fiacto/widgets/custom_app_bar.dart';
import 'package:fiacto/widgets/custom_pinput.dart';
import 'package:fiacto/widgets/rich_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPhoneVerificationPage extends StatelessWidget {
  const LoginPhoneVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final phone =
        context.read<AuthCubit>().state.userDataState.data?.phoneNo ?? '';
    return BlocProvider(
      create:
          (context) => TwoFaLoginCubit(
            repository: TwoFactorLoginRepoImpl(
              httpClient: context.read<HttpClient>(),
            ),
            auth: context.read<AuthCubit>(),
          ),
      child: Scaffold(
        backgroundColor: context.white,
        appBar: AppBarWidget(
          title: 'Verification',
          centerTitle: true,
          showLeading: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Two Factor Authentication',
                          style: context.twenty600,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'We have sent a verification code to $phone ',
                          style: context.sixteen400,
                        ),
                        const SizedBox(height: 32),
                        _PinCodeField(),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Didn't receive the code?",
                              style: context.twelve400,
                            ),
                            Text(
                              "Resend",
                              style: context.twelve500.withColor(
                                context.primary500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _VerifyCodeButton(),
                const SizedBox(height: 16),
                Center(
                  child: RichTextWidgets(
                    colorTextStyle: context.twelve500.withColor(
                      context.primary500,
                    ),
                    style: context.twelve400,
                    colorTitle: 'Customer Support',
                    simpleTitle: "Facing issues? We're here to assist. ",
                    onTap: (context) {},
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PinCodeField extends StatelessWidget {
  const _PinCodeField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TwoFaLoginCubit, TwoFaLoginState>(
      buildWhen: (previous, current) => previous.otp != previous.otp,
      builder: (context, state) {
        return Center(
          child: CustomPinputWidget(
            length: 4,
            onChanged: (p0) {
              context.read<TwoFaLoginCubit>().updateAuthenticatorCode(p0);
            },
          ),
        );
      },
    );
  }
}

class _VerifyCodeButton extends StatelessWidget {
  const _VerifyCodeButton();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TwoFaLoginCubit, TwoFaLoginState>(
          listenWhen:
              (previous, current) =>
                  previous.verifyLoginOtpDataState !=
                  current.verifyLoginOtpDataState,
          listener: (context, state) {
            if (state.verifyLoginOtpDataState.isFailure) {
              context.errorSnackbar(state.verifyLoginOtpDataState.errorMessage);
            } else if (state.verifyLoginOtpDataState.isLoaded) {
              final user = context.read<AuthCubit>().state.userDataState.data;
              if (user != null && user.token != null) {
                context.read<AuthRepository>().updateUser(
                  User.fromEntity(user),
                );
              }
              showDialog<void>(
                context: context,
                builder:
                    (context) => const CustomAlertDialog(
                      title: 'Account Verified!',
                      subTitle: 'Welcome back to your realwealtdy dashboard.',
                    ),
              );
              Future.delayed(const Duration(seconds: 4), () {
                if (!context.mounted) return;
                Navigator.pop(context);
                context.read<AuthRepository>().loginWithEmailPassword(
                  email: 'email',
                  password: 'password',
                );
              });
            }
          },
        ),
      ],
      child: BlocBuilder<TwoFaLoginCubit, TwoFaLoginState>(
        buildWhen:
            (previous, current) =>
                previous.status != previous.status ||
                previous.otp != current.otp ||
                previous.verifyLoginOtpDataState !=
                    current.verifyLoginOtpDataState,
        builder: (context, state) {
          return CustomElevatedButton.expanded(
            loading: state.verifyLoginOtpDataState.isLoading,
            enabled: state.otp.value.length == 4,
            text: 'Verify',
            onPressed: () {
              context.read<TwoFaLoginCubit>().verifyPhoneOtp();
            },
          );
        },
      ),
    );
  }
}
