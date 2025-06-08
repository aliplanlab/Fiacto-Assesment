import 'package:common/common.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fiacto/smsActivation/cubit/sms_activation_cubit.dart';
import 'package:fiacto/widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SmsActivationView extends StatelessWidget {
  const SmsActivationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Verification',
        centerTitle: true,
        showLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Enter Your Phone Number', style: context.sixteen400),
            const SizedBox(height: 16),
            const PhoneNumberWidget(),
            Spacer(),
            _SendCodeButton(),
          ],
        ),
      ),
    );
  }
}

class PhoneNumberWidget extends StatelessWidget {
  const PhoneNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
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
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  const SelectedCountryWidget(),
                  const SizedBox(width: 8),
                  const SelectedPhoneCode(),
                  const SizedBox(width: 4),
                  _CountryList(),
                ],
              ),
            ),
            const PhoneNumberTextField(),
          ],
        ),
      ],
    );
  }
}

class _CountryList extends StatelessWidget {
  const _CountryList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmsActivationCubit, SmsActivationState>(
      buildWhen:
          (previous, current) =>
              previous.selectedCountry != current.selectedCountry,
      builder: (context, state) {
        return IconButton(
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          padding: EdgeInsets.zero,
          iconSize: 12,
          onPressed: () {
            showCountryPicker(
              context: context,
              showPhoneCode: true,
              onSelect: context.read<SmsActivationCubit>().selectCountry,
            );
          },
          icon: const Icon(CupertinoIcons.chevron_down),
        );
      },
    );
  }
}

class SelectedPhoneCode extends StatelessWidget {
  const SelectedPhoneCode({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmsActivationCubit, SmsActivationState>(
      buildWhen:
          (previous, current) =>
              previous.selectedCountry != current.selectedCountry,
      builder: (context, state) {
        return Text(
          '+${state.selectedCountry.phoneCode}',
          style: context.sixteen400,
        );
      },
    );
  }
}

class SelectedCountryWidget extends StatelessWidget {
  const SelectedCountryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmsActivationCubit, SmsActivationState>(
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
    );
  }
}

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SmsActivationCubit, SmsActivationState>(
        buildWhen:
            (previous, current) => previous.phoneNumber != current.phoneNumber,
        builder: (context, state) {
          return CustomTextFormField(
            textInputAction: TextInputAction.done,
            initialValue: state.phoneNumber.value,
            onChanged: (value) {
              context.read<SmsActivationCubit>().changePhoneNumber(value);
            },
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
    );
  }
}

class _SendCodeButton extends StatelessWidget {
  const _SendCodeButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmsActivationCubit, SmsActivationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return CustomElevatedButton.expanded(
          text: 'Send Code',
          
          enabled: state.status.isValidated,
          onPressed: () {},
        );
      },
    );
  }
}
