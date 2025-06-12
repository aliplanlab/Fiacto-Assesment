import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, this.drawerItemDataList});

  final List<DrawerItemData>? drawerItemDataList;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final _tooltipController = OverlayPortalController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.78,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ..._buildItemList(
                    context,
                    widget.drawerItemDataList ?? DrawerItemData.data(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomOutlinedButton.expanded(
                textStyle: context.sixteen400,
                isSpacer: true,
                leading: AssetIcon.monotone(
                  AssetIcons.logout,
                  size: 24,
                  color: context.error500,
                ),
                borderColor: context.error50,
                backgroundColor: context.white,
                foregroundColor: context.error500,
                text: 'Sign Out',
                onPressed: () {
                  context.read<AuthRepository>().logOut();
                },
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildItemList(
  BuildContext context,
  List<DrawerItemData> itemDataList,
) {
  return [
    for (final DrawerItemData item in itemDataList)
      ListTile(
        leading:
            item.icon == null
                ? null
                : SizedBox(
                  height: 24,
                  child: AssetIcon.monotone(item.icon ?? AssetIcons.blank),
                ),
        horizontalTitleGap: 12,
        contentPadding: const EdgeInsets.only(left: 16, right: 16),
        title: Text(item.title, style: context.sixteen400),
        onTap: item.onTap,
      ),
  ];
}

class DrawerItemData {
  DrawerItemData({
    required this.title,
    this.icon,
    this.onTap,
    this.subRoutes = const [],
  });
  final String title;
  final AssetIcons? icon;
  final void Function()? onTap;
  final List<DrawerItemData> subRoutes;

  static List<DrawerItemData> data(BuildContext context) {
    return [
      DrawerItemData(
        title: 'Deals',
        icon: AssetIcons.deals,
        onTap: () {
          Navigator.of(context).pop();
          // Navigator.of(context).push(DealsPage.route());
        },
      ),
      DrawerItemData(
        title: 'Messages',
        icon: AssetIcons.messages,
        onTap: () {
          Navigator.of(context).pop();
          // Navigator.of(context).push(MessagePage.route());
        },
      ),
      DrawerItemData(
        title: 'Photography Service',
        icon: AssetIcons.photography_service,
        onTap: () {
          Navigator.of(context).pop();
          // Navigator.of(context).push(RequestServicePage.route());
        },
      ),
      DrawerItemData(
        title: 'Settings',
        icon: AssetIcons.settings,
        onTap: () {
          Navigator.of(context).pop();
          // Navigator.of(context).push(SettingPage.route());
        },
      ),
      DrawerItemData(
        title: 'Help Center',
        icon: AssetIcons.help_center,
        onTap: () {
          Navigator.of(context).pop();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute<TutorialPage>(
          //     builder: (_) => const TutorialPage(),
          //   ),
          // );
        },
      ),
      // DrawerItemData(
      //   title: 'Log out',
      //   icon: AssetIcons.authenticator_app,
      //   onTap: () {
      //     showDialog<AlertDialog>(
      //       context: context,
      //       builder: (BuildContext dialogContext) {
      //         return AlertDialog(
      //           title: Text(
      //             'Are you sure you want to log out?',
      //             style: context.twenty700,
      //           ),
      //           actions: <Widget>[
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.end,
      //               children: [
      //                 TextButton(
      //                   child: Text(
      //                     'Cancel',
      //                     style: context.sixteen400,
      //                   ),
      //                   onPressed: () {
      //                     Navigator.of(dialogContext)
      //                         .pop(); // Dismiss alert dialog
      //                   },
      //                 ),
      //                 TextButton(
      //                   child: Text(
      //                     'Yes, Confirm',
      //                     style: context.sixteen400,
      //                   ),
      //                   onPressed: () {
      //                     context.read<AuthRepository>().logOut();
      //                   },
      //                 ),
      //               ],
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //     //
      //   },
      // ),
    ];
  }
}
