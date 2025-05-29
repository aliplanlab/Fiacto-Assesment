import 'package:common/common.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: context.primary500,
      unselectedItemColor: context.grey500,
      elevation: 14,

      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: AssetIcon.monotone(AssetIcons.home_icon),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: AssetIcon.monotone(AssetIcons.credit_card),
          label: 'Card',
        ),
        BottomNavigationBarItem(
          icon: AssetIcon.monotone(AssetIcons.benefit_icon),
          label: 'Benefits',
        ),
        BottomNavigationBarItem(
          icon: AssetIcon.monotone(AssetIcons.discover),
          label: 'Discover',
        ),
      ],
    );
  }
}
