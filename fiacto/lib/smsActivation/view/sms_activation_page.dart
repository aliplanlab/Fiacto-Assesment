import 'package:common/http/http_client.dart';
import 'package:fiacto/smsActivation/cubit/sms_activation_cubit.dart';
import 'package:fiacto/smsActivation/repository/sms_activation_repo_impl.dart';
import 'package:fiacto/smsActivation/view/sms_verification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmsActivationPage extends StatelessWidget {
  const SmsActivationPage({super.key});

  static String route() => '/sms-activation';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => SmsActivationCubit(
            repository: SmsActivationRepoImpl(
              httpClient: context.read<HttpClient>(),
            ),
          ),
      child: const SmsActivationView(),
    );
  }
}
