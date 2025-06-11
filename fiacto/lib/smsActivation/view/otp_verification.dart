import 'package:common/common.dart';
import 'package:common/widgets/custom_alert_dialog.dart' show CustomAlertDialog;
import 'package:fiacto/auth/auth_cubit/auth_cubit.dart';
import 'package:fiacto/smsActivation/cubit/sms_activation_cubit.dart';
import 'package:fiacto/widgets/custom_app_bar.dart';
import 'package:fiacto/widgets/custom_pinput.dart';
import 'package:fiacto/widgets/rich_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key, required this.cubit});

  final SmsActivationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: context.white,
        appBar: AppBarWidget(
          title: '2FA Activation',
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
                          'Phone Number Verification',
                          style: context.twenty600,
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder<SmsActivationCubit, SmsActivationState>(
                          buildWhen:
                              (previous, current) =>
                                  previous.phone != previous.phone,
                          builder: (context, state) {
                            return Text(
                              'We have sent a verification code to ${state.phone}',
                              style: context.sixteen400,
                            );
                          },
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
    return BlocBuilder<SmsActivationCubit, SmsActivationState>(
      buildWhen: (previous, current) => previous.otp != previous.otp,
      builder: (context, state) {
        return Center(
          child: CustomPinputWidget(
            length: 4,
            onChanged: (p0) {
              context.read<SmsActivationCubit>().updateAuthenticatorCode(p0);
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
        BlocListener<SmsActivationCubit, SmsActivationState>(
          listenWhen:
              (previous, current) =>
                  previous.verifyOTPState != current.verifyOTPState,
          listener: (context, state) {
            if (state.verifyOTPState.isFailure) {
              context.errorSnackbar(state.verifyOTPState.errorMessage);
            } else if (state.verifyOTPState.isLoaded) {
              context.read<AuthCubit>().getUserBuilder();
            }
          },
        ),

        /// Listen to the state of the [AuthCubit] to determine
        /// the state of the updated user data.
        BlocListener<AuthCubit, AuthState>(
          listenWhen:
              (previous, current) =>
                  previous.getUserDataState != current.getUserDataState,
          listener: (context, state) async {
            if (state.getUserDataState.isFailure) {
              context.errorSnackbar(state.getUserDataState.errorMessage);
            } else if (state.getUserDataState.isLoaded) {
              final code =
                  context.read<SmsActivationCubit>().state.selectedCountry;
              final authState =
                  context.read<SmsActivationCubit>().state.phoneNumber;
              CustomAlertDialog.show(
                context: context,
                title: '2F Authentication Activated!',
                subTitle:
                    'You’ll be receiving verification codes to +${code.phoneCode}${authState.value}',
              );

              await Future<void>.delayed(const Duration(seconds: 3));
              if (!context.mounted) return;
              Navigator.pop(context);
              final data = state.getUserDataState.data;
              final token = context.read<AuthRepository>().currentUser.token;
              if (data != null) {
                context.read<AuthRepository>().updateUser(
                  User.fromEntity(data, token),
                );
              }
            }
          },
        ),
      ],
      child: BlocBuilder<SmsActivationCubit, SmsActivationState>(
        buildWhen:
            (previous, current) =>
                previous.status != previous.status ||
                previous.otp != current.otp ||
                previous.verifyOTPState != current.verifyOTPState,
        builder: (context, state) {
          return CustomElevatedButton.expanded(
            loading: state.verifyOTPState.isLoading,
            enabled: state.otp.value.length == 4,
            text: 'Verify',
            onPressed: () {
              context.read<SmsActivationCubit>().verifyOTP();
            },
          );
        },
      ),
    );
  }
}
