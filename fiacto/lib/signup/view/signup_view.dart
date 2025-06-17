part of 'view.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpCubit, SignUpState>(
          listenWhen:
              (previous, current) =>
                  previous.signUpDataState != current.signUpDataState,
          listener: (context, state) {
            if (state.signUpDataState.isFailure) {
              context.errorSnackbar(state.signUpDataState.errorMessage);
            } else if (state.signUpDataState.isLoaded) {
              _showVerificationSentDialog(context, state.signUpDataState.data!);
            }
          },
        ),

        BlocListener<SignUpCubit, SignUpState>(
          listenWhen:
              (previous, current) =>
                  previous.socialSignUpDataState !=
                  current.socialSignUpDataState,
          listener: (context, state) {
            if (state.socialSignUpDataState.isLoaded) {
              final user = state.socialSignUpDataState.data;
              if (user != null && user.token?.notBlank != null) {
                context.read<AuthRepository>().updateUser(
                  User.fromEntity(user),
                );
              }
            } else if (state.socialSignUpDataState.isFailure) {
              context.errorSnackbar(state.socialSignUpDataState.errorMessage);
            }
          },
        ),
      ],
      child: const _BodyView(),
    );
  }
}

Future<void> _showVerificationSentDialog(
  BuildContext context,
  UserEntity user,
) async {
  CustomAlertDialog.show(
    context: context,
    title: 'Verification Link Sent!',
    subTitle:
        'An email has been sent to your address with your verification Link.',
  );
  await Future<void>.delayed(const Duration(seconds: 2));
  if (!context.mounted) return;
  Navigator.of(context).pop();
  context.read<AuthRepository>().updateUser(User.fromEntity(user));
}

class _BodyView extends StatelessWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Verification',
        centerTitle: true,
        showLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Let’s Get You Started',
                style: context.twenty600.withColor(Colors.black),
              ),
              SizedBox(height: 8),
              Text(
                'Sign up to manage your crypto and convert it to fiat anytime, anywhere.',
                style: context.fourteen400.withColor(context.grey500),
              ),
              SizedBox(height: 24),
              _FullNameField(),
              SizedBox(height: 16),
              _EmailField(),
              SizedBox(height: 16),
              _PasswordField(),
              SizedBox(height: 16),
              _ContinueButton(),
              SizedBox(height: 24),
              _ContinueWithGoogle(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _FullNameField extends StatelessWidget {
  const _FullNameField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.fullName != current.fullName,
      builder: (context, state) {
        return CustomTextFormField(
          labelText: 'Full Name',
          hintText: 'Enter your Name',
          onChanged: (value) {
            context.read<SignUpCubit>().fullNameChanged(value);
          },
        );
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextFormField(
          labelText: 'Email',
          hintText: 'Enter Your Email',
          onChanged: (value) {
            context.read<SignUpCubit>().emailChanges(value);
          },
        );
      },
    );
  }
}

// class _PhoneNumberField extends StatelessWidget {
//   const _PhoneNumberField();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignUpCubit, SignUpState>(
//       buildWhen:
//           (previous, current) => previous.phoneNumber != current.phoneNumber,
//       builder: (context, state) {
//         return CustomTextFormField(
//           labelText: 'Phone Number',
//           hintText: 'Enter Your Phone Number',
//           onChanged: (value) {
//             context.read<SignUpCubit>().phoneNumber(value);
//           },
//         );
//       },
//     );
//   }
// }

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen:
          (previous, current) =>
              previous.password != current.password ||
              previous.passwordVisible != current.passwordVisible,
      builder: (context, state) {
        return CustomTextFormField(
          labelText: 'Password',
          hintText: '************',
          obscureText: !state.passwordVisible,
          suffixIcon: InkWell(
            onTap: () {
              context.read<SignUpCubit>().isVisible(!state.passwordVisible);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset('assets/icons/visibility.png'),
            ),
          ),
          onChanged: (value) {
            context.read<SignUpCubit>().passwordChanged(value);
          },
        );
      },
    );
  }
}

// class _ConfirmPasswordField extends StatelessWidget {
//   const _ConfirmPasswordField();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignUpCubit, SignUpState>(
//       buildWhen:
//           (previous, current) =>
//               previous.confirmPassword != current.confirmPassword ||
//               previous.confirmPasswordVisible != current.confirmPasswordVisible,
//       builder: (context, state) {
//         return CustomTextFormField(
//           labelText: 'Confirm Password',
//           hintText: '************',
//           obscureText: !state.confirmPasswordVisible,
//           suffixIcon: InkWell(
//             onTap: () {
//               context.read<SignUpCubit>().confirmPasswordVisible(
//                 !state.confirmPasswordVisible,
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Image.asset('assets/icons/visibility.png'),
//             ),
//           ),
//           onChanged: (value) {
//             context.read<SignUpCubit>().confirmPasswordChanged(value);
//           },
//         );
//       },
//     );
//   }
// }

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen:
          (previous, current) =>
              previous.isValidated != current.isValidated ||
              previous.signUpDataState != current.signUpDataState,
      builder: (context, state) {
        return CustomElevatedButton.expanded(
          loading: state.signUpDataState.isLoading,
          enabled: state.isValidated,
          onPressed: () {
            context.read<SignUpCubit>().signUpWithEmail();
          },
          text: 'Continue',
        );
      },
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).maybePop(),
      child: Container(
        padding: const EdgeInsets.all(2),
        height: 20,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Center(
          child: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
        ),
      ),
    );
  }
}

class _ContinueWithGoogle extends StatelessWidget {
  const _ContinueWithGoogle();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen:
          (previous, current) =>
              previous.socialSignUpDataState != current.socialSignUpDataState,
      builder: (context, state) {
        return CustomOutlinedButton(
          onPressed: () {
            context.read<SignUpCubit>().signUpWithGoogle();
          },
          loading:
              state.socialSignUpDataState.key == 'google' &&
              state.socialSignUpDataState.isLoading,
          enabled:
              state.socialSignUpDataState.isInitial ||
              state.socialSignUpDataState.isFailure,
          borderRadius: 4.0,
          width: double.infinity,
          leading: const AssetIcon.multicolor(AssetIcons.google_icon),
          text: 'Continue with Google',
        );
      },
    );
  }
}
