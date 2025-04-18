import 'package:flutter/material.dart';
import '../constants/text_styles.dart';

class InfoStateWidget extends StatelessWidget {
  final String message;
  final Widget? action;

  const InfoStateWidget({super.key, required this.message, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: AppTextStyles.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
