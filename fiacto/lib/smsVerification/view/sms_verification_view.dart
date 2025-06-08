import 'package:common/common.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fiacto/smsVerification/cubit/sms_activation_cubit.dart';
import 'package:fiacto/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SmsVerificationView extends StatelessWidget {
  const SmsVerificationView({super.key});

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
            Text('Enter Your Phone Number', style: context.sixteen400),
            const SizedBox(height: 8),
            const _PhoneInputView(),
            Spacer(),
            _SendCodeButton(),
          ],
        ),
      ),
    );
  }
}

class _PhoneInputView extends StatelessWidget {
  const _PhoneInputView();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            border: Border(
              bottom: BorderSide(color: context.grey300),
              top: BorderSide(color: context.grey300),
              left: BorderSide(color: context.grey300),
            ), // Adjust border
          ),
          child: CustomInkWell(
            onTap:
                () => showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  onSelect: context.read<SmsActivationCubit>().selectCountry,
                ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                BlocBuilder<SmsActivationCubit, SmsActivationState>(
                  buildWhen:
                      (previous, current) =>
                          previous.selectedCountry != current.selectedCountry,
                  builder: (context, state) {
                    return CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            state.selectedCountry.flagEmoji,
                            style: const TextStyle(fontSize: 50),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                BlocBuilder<SmsActivationCubit, SmsActivationState>(
                  buildWhen:
                      (previous, current) =>
                          previous.selectedCountry != current.selectedCountry,
                  builder: (context, state) {
                    return Text(
                      '+${state.selectedCountry.phoneCode}',
                      style: context.sixteen400,
                    );
                  },
                ),
                const SizedBox(width: 4),
                IconButton(
                  visualDensity: const VisualDensity(
                    horizontal: -4,
                    vertical: -4,
                  ),
                  padding: EdgeInsets.zero,
                  iconSize: 12,
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.chevron_down),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<SmsActivationCubit, SmsActivationState>(
            buildWhen:
                (previous, current) =>
                    previous.phoneNumber != current.phoneNumber,
            builder: (context, state) {
              return CustomTextFormField(
                hasError: state.phoneNumber.invalid,
                onChanged: context.read<SmsActivationCubit>().phoneNumber,
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
                keyboardType: TextInputType.number,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                hintText: 'ex. 234 567 890',
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SendCodeButton extends StatelessWidget {
  const _SendCodeButton();

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.expanded(text: 'Send Code', onPressed: () {});
  }
}
