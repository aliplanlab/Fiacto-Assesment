import 'package:common/common.dart';
import 'package:fiacto/dashboard/view/view.dart';
import 'package:fiacto/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class VerficationSuccess extends StatelessWidget {
  const VerficationSuccess({super.key});

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
            Image.asset('assets/images/success.png'),
            const SizedBox(height: 24),
            Text(
              '2FA Enabled!',
              style: context.twenty600.withColor(Colors.black),
            ),
            const SizedBox(height: 24),
            Text(
              textAlign: TextAlign.center,
              'Your wallet is now protected by two-factor authentication.',
              style: context.fourteen400.withColor(context.grey500),
            ),
            Spacer(),
            _ContinueButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.expanded(
      text: 'Continue',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DashboardPage()),
        );
      },
    );
  }
}
