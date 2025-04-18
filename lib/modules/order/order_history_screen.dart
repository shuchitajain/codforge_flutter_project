import '../../core/constants/strings.dart';
import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/widgets/coming_soon_widget.dart' show ComingSoonWidget;
import '../../core/widgets/common_appbar.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppbar(title: AppStrings.orderHistory),
      body: ComingSoonWidget(
        title: AppStrings.orderComingSoon,
        imagePath: 'assets/illustrations/order_illustration.jpg',
      ),
    );
  }
}
