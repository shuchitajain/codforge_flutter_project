import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/widgets/coming_soon_widget.dart';
import '../../core/widgets/common_appbar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppbar(title: AppStrings.cart),
      body: ComingSoonWidget(
        title: AppStrings.cartComingSoon,
        imagePath: 'assets/illustrations/cart_illustration.jpg',
      ),
    );
  }
}
