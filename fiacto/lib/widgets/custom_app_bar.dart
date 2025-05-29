import 'package:common/constants/asset_icons.dart';
import 'package:common/widgets/asset_icon.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool showLeading;
  final VoidCallback? onBack;

  const AppBarWidget({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.showLeading = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      leading:
          showLeading
              ? Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: GestureDetector(
                  onTap: onBack ?? () => Navigator.of(context).maybePop(),
                  child: Container(
                    height: 40,
                    width: 50,
                    decoration: BoxDecoration(
                      shape:
                          BoxShape.circle, // 💫 This makes it perfectly round
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: AssetIcon.monotone(
                        AssetIcons.arrow_left,
                        color: Colors.black,
                        size: 20, // optional size tweak
                      ),
                    ),
                  ),
                ),
              )
              : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
