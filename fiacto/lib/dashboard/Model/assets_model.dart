import 'package:common/constants/asset_icons.dart';

class CurrencyRate {
  final String code;
  final String rate;
  final bool isUp;
  final AssetIcons icon;

  CurrencyRate({
    required this.code,
    required this.rate,
    required this.isUp,
    required this.icon,
  });

  static List<CurrencyRate> rates = [
    CurrencyRate(
      code: 'Bitcoin (BTC)',
      rate: '1,250.00',
      isUp: true,
      icon: AssetIcons.bitcoin,
    ),
    CurrencyRate(
      code: 'Ethereum(ETH)',
      rate: '1,250.00',
      isUp: false,
      icon: AssetIcons.ethereum,
    ),
    CurrencyRate(
      code: 'Bitcoin (BTC)',
      rate: '1,250.00',
      isUp: true,
      icon: AssetIcons.bitcoin,
    ),
  ];
}
