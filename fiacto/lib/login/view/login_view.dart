part of 'view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Image.asset('assets/images/logo_circle.png', height: 60),
                SizedBox(height: 24),
                Text('Get Started Now', style: context.twenty600),
                SizedBox(height: 8),
                Text(
                  'Create an account or log in to explore about our app',
                  style: context.fourteen400.withColor(context.grey500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                _EmailTextField(),
                SizedBox(height: 16),
                _PasswordTextField(),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_RememberMe(), _ForgotPassword()],
                ),
                SizedBox(height: 24),
                _LoginButton(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.28),
                RichTextWidget(
                  title: "Don't have an account? ",
                  colorTitle: 'Create One',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpPage()),
                    );
                  },
                  titleStyle: context.fourteen500.withColor(context.grey500),
                  colorTitleStyle: context.fourteen500.withColor(
                    context.primary500,
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextFormField(
          labelText: 'Email',
          hintText: 'Enter your Email',
          hasError: state.email.invalid,
          keyboardType: TextInputType.emailAddress,
          onChanged: context.read<LoginCubit>().email,
        );
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen:
          (previous, current) =>
              previous.password != current.password ||
              previous.isVisible != current.isVisible,
      builder: (context, state) {
        return CustomTextFormField(
          labelText: 'Password',
          hasError: state.password.invalid,
          onChanged: context.read<LoginCubit>().password,
          obscureText: !state.isVisible,
          hintTextStyle: context.sixteen400.withColor(context.grey400),
          hintText: '************',
          suffixIcon: InkWell(
            onTap: () {
              context.read<LoginCubit>().isVisible(!state.isVisible);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset('assets/icons/visibility.png'),
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen:
          (previous, current) =>
              previous.loginDataState != current.loginDataState,
      listener: (context, state) {
        if (state.isLoginSuccessFull) {
          _checkUserStatus(context, state.user);
        } else if (state.loginDataState.isFailure) {
          context.errorSnackbar(state.loginDataState.errorMessage);
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen:
            (previous, current) =>
                previous.status != current.status ||
                previous.loginDataState != current.loginDataState,
        builder: (context, state) {
          return CustomElevatedButton.expanded(
            enabled: state.status.isValidated,
            loading: state.loginDataState.isLoading,
            onPressed: () {
              context.read<LoginCubit>().loginWithEmailPassword();
            },
            text: 'Login',
          );
        },
      ),
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Forgot Password?',
        style: context.fourteen500.withColor(context.primary500),
      ),
    );
  }
}

class _RememberMe extends StatelessWidget {
  const _RememberMe();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.isCheck != current.isCheck,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<LoginCubit>().isCheck(!state.isCheck);
          },
          child: Row(
            children: [
              Checkbox(
                side: BorderSide(color: context.grey300),
                activeColor: state.isCheck ? context.primary500 : context.white,
                visualDensity: const VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                value: state.isCheck,
                onChanged: (value) {
                  context.read<LoginCubit>().isCheck(!state.isCheck);
                },
                // title:
              ),
              Text(
                'Remember Me',
                style: context.fourteen500.withColor(context.grey500),
              ),
            ],
          ),
        );
      },
    );
  }
}

void _checkUserStatus(BuildContext context, UserEntity userEntity) {
  final user = User.fromEntity(userEntity);

  if (user.isTwoFactorAuthenticatorComplete || user.isTwoFactorPhoneComplete) {
    context.read<AuthCubit>().updateUser(userEntity);
    if (user.isTwoFactorAuthenticatorComplete &&
        user.isTwoFactorPhoneComplete) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (_) => const TwoFAWalletPage()),
      );
    } else if (user.isTwoFactorPhoneComplete) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => const LoginPhoneVerificationPage(),
        ),
      );
    } else if (user.isTwoFactorAuthenticatorComplete) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => const LoginAuthenticatorVerificationPage(),
        ),
      );
    }
  } else {
    context.read<AuthRepository>().updateUser(user);
  }
}

Future<void> _showVerificationSentDialog(
  BuildContext context,
  UserEntity user,
) async {
  CustomAlertDialog.show(
    context: context,
    title: 'Verification Code Sent!',
    subTitle:
        'An email has been sent to your address with your verification OTP.',
  );
  await Future<void>.delayed(const Duration(seconds: 2));
  if (!context.mounted) return;
  Navigator.of(context).pop(); // Close the first dialog
}
