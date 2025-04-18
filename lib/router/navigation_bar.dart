import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/colors.dart';
import '../modules/home/home_screen.dart';
import '../modules/category/category_screen.dart';
import '../modules/cart/cart_screen.dart';
import '../modules/profile/profile_screen.dart';
import '../modules/order/order_history_screen.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 1);

class AppScaffold extends ConsumerWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      backgroundColor: AppColors.grey100,
      body: IndexedStack(
        index: index,
        children: const [
          HomeScreen(),
          CategoryScreen(),
          CartScreen(),
          OrderHistoryScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          currentIndex: index,
          onTap: (i) => ref.read(bottomNavIndexProvider.notifier).state = i,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.lightGreen800,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen800,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColors.white,
                    ),
                  ),
                  Positioned(
                    right: -1,
                    bottom: 30,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      constraints: BoxConstraints(minWidth: 18, minHeight: 18),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen800,
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(color: AppColors.white, width: 1),
                        ),
                      ),
                      child: Center(
                        child: const Text(
                          '2',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
