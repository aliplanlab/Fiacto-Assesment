part of 'view.dart';

class SecureWalletView extends StatelessWidget {
  const SecureWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _BodyView();
  }
}

class _BodyView extends StatelessWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Secure Your Wallet',
        centerTitle: true,
        titleTextStyle: context.sixteen500,
        showLeading: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: BackButton(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'Add an Extra Layer of Security',
              style: context.twenty600.withColor(Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              'Set up 2FA to keep your wallet safe from unauthorized access.',
              style: context.fourteen400.withColor(context.grey500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _AuthAppButton(),
            const SizedBox(height: 24),
            _SMSVerificationButton(),
          ],
        ),
      ),
    );
  }
}

class _SMSVerificationButton extends StatelessWidget {
  const _SMSVerificationButton();

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton.expanded(
      text: 'SMS Verification',
      borderRadius: 10,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const VerficiationPage()));
      },
    );
  }
}

class _AuthAppButton extends StatelessWidget {
  const _AuthAppButton();

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton.expanded(
      borderColor: context.primary500,
      text: 'Authenticator App',
      borderRadius: 10,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VerficiationPage()),
        );
      },
    );
  }
}
