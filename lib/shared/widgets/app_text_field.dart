import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType? keyboardType;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.rubik(fontSize: 18, color: AppColors.ink),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && _hidden,
          keyboardType: widget.keyboardType,
          style: GoogleFonts.rubik(fontSize: 20, color: AppColors.ink),
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? Padding(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () => setState(() => _hidden = !_hidden),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFE3DDFF),
                  foregroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(
                  _hidden ? 'Mostra' : 'Nascondi',
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
                : null,
          ),
        ),
      ],
    );
  }
}