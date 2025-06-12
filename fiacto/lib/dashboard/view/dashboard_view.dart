part of 'view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _BodyView();
  }
}

class _BodyView extends StatelessWidget {
  const _BodyView();

  @override
  Widget build(BuildContext context) {
    final currencyRatesList = CurrencyRate.rates;
    final transactionHistory = TransactionModel.transactions;
    return Scaffold(
      drawer: const CustomDrawer(),

      appBar: DrawerCustomAppBar(
        drawer: Builder(
          builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: AssetIcon.monotone(AssetIcons.menu),
              ),
            );
          },
        ),
        titleWidget: Image.asset('assets/images/logo.png', width: 100),
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 12),
              VisaCardWithGradient(
                balance: 1250.0,
                onDeposit: () {},
                onSend: () {},
                onConvert: () {},
                onWithdraw: () {},
              ),
              SizedBox(height: 12),
              CustomHorizontalRow(
                title: Text(
                  'My Assets',
                  style: context.sixteen500.withColor(Colors.black),
                ),
                suffix: TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: context.sixteen500.withColor(context.primary500),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _CurrencyRatesWidget(currencyRatesList: currencyRatesList),
              SizedBox(height: 16),
              CustomHorizontalRow(
                title: Text(
                  'Transactions',
                  style: context.sixteen500.withColor(Colors.black),
                ),
                suffix: TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: context.sixteen500.withColor(context.primary500),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _TransactionHistoryWidget(currencyRatesList: transactionHistory),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrencyRatesWidget extends StatelessWidget {
  const _CurrencyRatesWidget({required this.currencyRatesList});

  final List<CurrencyRate> currencyRatesList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: currencyRatesList.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final rate = currencyRatesList[index];
          return _CurrencyRateTile(rate: rate);
        },
      ),
    );
  }
}

class _TransactionHistoryWidget extends StatelessWidget {
  const _TransactionHistoryWidget({required this.currencyRatesList});

  final List<TransactionModel> currencyRatesList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: currencyRatesList.length,
      itemBuilder: (context, index) {
        final rate = currencyRatesList[index];
        return _TransactionsListTile(rate: rate);
      },
    );
  }
}

class VisaCardWithGradient extends StatelessWidget {
  const VisaCardWithGradient({
    super.key,
    required this.balance,
    required this.onDeposit,
    required this.onSend,
    required this.onConvert,
    required this.onWithdraw,
  });

  final double balance;
  final VoidCallback onDeposit;
  final VoidCallback onSend;
  final VoidCallback onConvert;
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Gradient background
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFFD0F5D8), Color(0xFFEFFEF3)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),

        // Visa Card on top
        _VisaCardWidget(
          balance: balance,
          onDeposit: onDeposit,
          onSend: onSend,
          onConvert: onConvert,
          onWithdraw: onWithdraw,
        ),
      ],
    );
  }
}

class _VisaCardWidget extends StatelessWidget {
  const _VisaCardWidget({
    required this.balance,
    required this.onDeposit,
    required this.onSend,
    required this.onConvert,
    required this.onWithdraw,
  });

  final double balance;
  final VoidCallback onDeposit;
  final VoidCallback onSend;
  final VoidCallback onConvert;
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 265,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.primary700,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 55,
            child: Image.asset(
              'assets/images/card_photo.png',
              width: 255,
              fit: BoxFit.cover,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopCardWidget(balance: balance),
              const Spacer(),
              _BottomCardWidget(
                onDeposit: onDeposit,
                onSend: onSend,
                onConvert: onConvert,
                onWithdraw: onWithdraw,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomCardWidget extends StatelessWidget {
  const _BottomCardWidget({
    required this.onDeposit,
    required this.onSend,
    required this.onConvert,
    required this.onWithdraw,
  });

  final VoidCallback onDeposit;
  final VoidCallback onSend;
  final VoidCallback onConvert;
  final VoidCallback onWithdraw;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0XFF002620),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CardActionButton(
              label: 'Deposit',
              icon: AssetIcon.multicolor(AssetIcons.deposit),
              onTap: onDeposit,
            ),
            _CardActionButton(
              label: 'Send',
              icon: AssetIcon.monotone(AssetIcons.send, color: Colors.blue),
              onTap: onSend,
            ),
            _CardActionButton(
              label: 'Convert',
              icon: AssetIcon.multicolor(AssetIcons.convert),
              onTap: onConvert,
            ),
            _CardActionButton(
              label: 'Withdraw',
              icon: AssetIcon.monotone(
                AssetIcons.withdraw,
                color: Colors.black,
              ),
              onTap: onWithdraw,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopCardWidget extends StatelessWidget {
  const _TopCardWidget({required this.balance});

  final double balance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHorizontalRow(
            title: Text(
              'Credit',
              style: context.twelve400.withColor(Colors.white),
            ),
            suffix: AssetIcon.multicolor(AssetIcons.visa_logo),
          ),
          const SizedBox(height: 33),

          Text(
            '\$${balance.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          _AvailableBalanceWidget(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _AvailableBalanceWidget extends StatelessWidget {
  const _AvailableBalanceWidget();

  @override
  Widget build(BuildContext context) {
    return CustomHorizontalRow(
      title: Text(
        'Available Balance',
        style: context.twelve400.withColor(Colors.white),
      ),
      suffix: Text(
        '**** 3090',
        style: context.twelve400.withColor(Colors.white),
      ),
    );
  }
}

class _CardActionButton extends StatelessWidget {
  final String label;
  final AssetIcon icon;
  final VoidCallback onTap;

  const _CardActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: icon,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _CurrencyRateTile extends StatelessWidget {
  final CurrencyRate rate;

  const _CurrencyRateTile({required this.rate});

  @override
  Widget build(BuildContext context) {
    final rateColor = rate.isUp ? Colors.green : Colors.red;
    final rateIcon = rate.isUp ? AssetIcons.trade_up : AssetIcons.trade_up;
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.grey400),
      ),
      child: ListTile(
        leading: AssetIcon.multicolor(rate.icon, size: 50),
        title: Text(
          rate.code,
          style: context.sixteen500.withColor(Colors.black),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '\$${rate.rate}',
                style: context.twelve400.withColor(Colors.grey),
              ),
            ),
            Row(
              children: [
                Text(
                  '2.35',
                  style: context.twelve400.withColor(context.primary500),
                ),
                const SizedBox(width: 4),
                AssetIcon.multicolor(rateIcon, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionsListTile extends StatelessWidget {
  final TransactionModel rate;

  const _TransactionsListTile({required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: context.grey300,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Image.asset('assets/images/avatar.png', fit: BoxFit.cover),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(rate.name, style: context.sixteen500.withColor(Colors.black)),
            Text(
              rate.amount,
              style: context.sixteen500.withColor(Colors.black),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              rate.transferType,
              style: context.twelve400.withColor(Colors.grey),
            ),
            Text(rate.date, style: context.twelve400.withColor(Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class DrawerCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget drawer;
  final VoidCallback onNotificationTap;
  final VoidCallback onProfileTap;
  final Widget? titleWidget;

  const DrawerCustomAppBar({
    super.key,
    required this.drawer,
    required this.onNotificationTap,
    required this.onProfileTap,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: titleWidget ?? const SizedBox(),
      leading: drawer,
      actions: [
        IconButton(
          onPressed: onNotificationTap,
          icon: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white,
            child: AssetIcon.multicolor(AssetIcons.alert, size: 50),
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onProfileTap,
          child: const CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
