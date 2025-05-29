import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.subTitle,
    this.isButtonAvailable = false,
    this.onPressed,
    this.buttonTitle,
  });
  final String title;
  final String subTitle;
  final bool isButtonAvailable;
  final VoidCallback? onPressed;
  final String? buttonTitle;

  static void show({
    required BuildContext context,
    required String title,
    required String subTitle,
    bool isButtonAvailable = false,
  }) {
    showDialog<void>(
      barrierDismissible: isButtonAvailable,
      context: context,
      builder: (ctx) {
        return CustomAlertDialog(
          title: title,
          subTitle: subTitle,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: context.primary500,
        ),
      ),
      elevation: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/approved_dialog.json',
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Text(
            textAlign: TextAlign.center,
            title,
            style: context.twenty600,
          ),
          const SizedBox(height: 8),
          Text(
            textAlign: TextAlign.center,
            subTitle,
            style: context.sixteen400,
          ),
          const SizedBox(height: 8),
          if (isButtonAvailable) ...[
            const SizedBox(
              height: 26,
            ),
            CustomElevatedButton.expanded(
              text: buttonTitle ?? 'Take me to the Dashboard',
              onPressed: onPressed,
            ),
          ],
        ],
      ),
    );
  }
}
