import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.current, required this.onTap});

  final int current;
  final ValueChanged<int> onTap;

  static const _tabs = [
    (Icons.home_outlined, 'Home'),
    (Icons.menu_book_outlined, 'Lezioni'),
    (Icons.calendar_today_outlined, 'Incontri'),
    (Icons.emoji_events_outlined, 'Classifica'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          for (int i = 0; i < _tabs.length; i++)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: i == current
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_tabs[i].$1, color: Colors.white, size: 26),
                      const SizedBox(height: 2),
                      Text(
                        _tabs[i].$2,
                        style: GoogleFonts.rubik(
                          fontSize: 13,
                          fontWeight:
                          i == current ? FontWeight.w700 : FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}