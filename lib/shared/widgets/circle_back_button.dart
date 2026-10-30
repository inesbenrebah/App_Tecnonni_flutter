import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';

class CircleBackButton extends StatelessWidget {
  const CircleBackButton({
    super.key,
    this.to = '/',
    this.onDark = false,
  });
  final String to;
  final bool onDark; // translucent version for purple headers

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: onDark ? Colors.white.withValues(alpha: 0.2) : Colors.white,
        shape: onDark
            ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))
            : const CircleBorder(),
        child: InkWell(
          customBorder: onDark
              ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))
              : const CircleBorder(),
          onTap: () => context.canPop() ? context.pop() : context.go(to),
          child: SizedBox(
            width: 56,
            height: 56,
            child: Icon(
              Icons.chevron_left,
              color: onDark ? Colors.white : AppColors.primary,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}