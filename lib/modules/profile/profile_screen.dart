import '../../core/constants/strings.dart';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/widgets/coming_soon_widget.dart' show ComingSoonWidget;
import '../../core/widgets/common_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppbar(title: AppStrings.profile),
      body: ComingSoonWidget(
        title: AppStrings.profileComingSoon,
        imagePath: 'assets/illustrations/profile_illustration.jpg',
      ),
    );
  }
}
