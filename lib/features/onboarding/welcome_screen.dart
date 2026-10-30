import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';
import 'package:app_tecnonni_flutter/shared/widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -90,
            left: -80,
            child: _Circle(size: 260, color: Colors.white.withValues(alpha: 0.12)),
          ),
          Positioned(
            bottom: -130,
            right: -100,
            child: _Circle(size: 320, color: const Color(0xFF8A5FD0)),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _AppLogo(),
                  const SizedBox(height: 40),
                  Text(
                    'Tecnonni',
                    style: GoogleFonts.rubik(
                      fontSize: 44,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'La tecnologia, spiegata con calma.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      height: 1.35,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 48),
                  AppButton(
                    label: 'Iniziamo',
                    background: AppColors.yellow,
                    foreground: AppColors.ink,
                    onPressed: () => context.go('/onboarding'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(48, 56),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Ho già un account',
                      style: GoogleFonts.rubik(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _AppLogo extends StatelessWidget {
  const _AppLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(42),
      ),
      child: Center(
        child: Container(
          width: 66,
          height: 118,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.ink, width: 6),
          ),
          child: const Center(
            child: Icon(Icons.favorite, color: AppColors.coral, size: 36),
          ),
        ),
      ),
    );
  }
}