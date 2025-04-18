import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import 'package:flutter/material.dart';

class CommonAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppbar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  State<CommonAppbar> createState() => _CommonAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _CommonAppbarState extends State<CommonAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      backgroundColor: AppColors.grey100,
      elevation: 1,
      leading:
          widget.leading ??
          IconButton(
            icon: CircleAvatar(
              backgroundColor: AppColors.white,
              child: const Icon(Icons.arrow_back_ios_new, 
              color: AppColors.green,
              size: 20,
              ),
            ),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppStrings.noPreviousScreen,
                      style: TextStyle(color: AppColors.black),
                    ),
                    backgroundColor: AppColors.lightGreen100,
                  ),
                );
              }
            },
          ),
      actions: widget.actions,
    );
  }
}
