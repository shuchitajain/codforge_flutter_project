import '../../core/constants/strings.dart';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/widgets/coming_soon_widget.dart' show ComingSoonWidget;
import '../../core/widgets/common_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppbar(title: AppStrings.home),
      body: ComingSoonWidget(
        title: AppStrings.homeComingSoon,
        imagePath: 'assets/illustrations/home_illustration.jpg',
      ),
    );
  }
}
