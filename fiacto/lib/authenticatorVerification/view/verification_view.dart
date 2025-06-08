import 'package:common/common.dart';
import 'package:fiacto/authenticatorVerification/view/verification_success.dart';
import 'package:fiacto/widgets/custom_app_bar.dart';
import 'package:fiacto/widgets/custom_pinput.dart';
import 'package:flutter/material.dart';

class VerficationView extends StatelessWidget {
  const VerficationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Verification',
        centerTitle: true,
        showLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
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
            CustomPinputWidget(),
            const SizedBox(height: 24),
            Text(
              'The code refreshes every 30 seconds 20',
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

class _VerifyAndEnableButton extends StatelessWidget {
  const _VerifyAndEnableButton();

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.expanded(
      text: 'Verify & Enable 2FA',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VerficationSuccess()),
        );
      },
    );
  }
}
