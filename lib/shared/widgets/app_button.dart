import 'package:flutter/material.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.background = AppColors.primary,
    this.foreground = Colors.white,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final Color background;
  final Color foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 68,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 24),
            ],
          ],
        ),
      ),
    );
  }
}