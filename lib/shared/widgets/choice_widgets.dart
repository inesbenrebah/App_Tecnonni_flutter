import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';

/// "Aa" box with a label underneath
class SizeOption extends StatelessWidget {
  const SizeOption({
    super.key,
    required this.label,
    required this.fontSize,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final double fontSize;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFFE3DDFF) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? AppColors.primary : const Color(0xFFD9D0FF),
                  width: selected ? 3 : 2,
                ),
              ),
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: Text(
                  'Aa',
                  style: GoogleFonts.rubik(
                    fontSize: fontSize,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                    color: AppColors.ink,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                fontSize: 14,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                color: selected ? AppColors.ink : AppColors.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Rounded option like "Lenta / Normale / Veloce"
class PillChoice extends StatelessWidget {
  const PillChoice({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected ? AppColors.primary : const Color(0xFFD9D0FF),
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.rubik(
            fontSize: 18,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
            color: selected ? Colors.white : AppColors.ink,
          ),
        ),
      ),
    );
  }
}