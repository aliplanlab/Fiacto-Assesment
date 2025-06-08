import 'package:fiacto/smsActivation/cubit/sms_activation_cubit.dart';
import 'package:fiacto/smsActivation/view/sms_verification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmsActivationPage extends StatelessWidget {
  const SmsActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SmsActivationCubit(),
      child: const SmsActivationView(),
    );
  }
}
