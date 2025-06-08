// import 'package:fiacto/Benefits/view/benefit_page.dart';
// import 'package:fiacto/Card/view/card_page.dart';
// import 'package:fiacto/Discover/view/discover.dart';
// import 'package:fiacto/dashboard/view/view.dart';
// import 'package:fiacto/widgets/bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   static String route() => '/main';

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _screens = [
//     DashboardPage(),
//     CardPage(),
//     BenefitPage(),
//     DiscoverPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
