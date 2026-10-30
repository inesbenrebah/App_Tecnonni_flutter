import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';
import 'package:app_tecnonni_flutter/shared/widgets/app_bottom_nav.dart';
import 'package:app_tecnonni_flutter/shared/widgets/circle_back_button.dart';

enum _State { done, current, locked }

class PhonePathScreen extends StatelessWidget {
  const PhonePathScreen({super.key});

  // Demo data, later it will come from the database
  static const _modules = [
    ('Le basi', '3 di 3 lezioni • Completato', _State.done),
    ('Messaggi e chiamate', '1 di 3 lezioni • In corso', _State.current),
    ('Internet e Wi-Fi', '0 di 3 lezioni', _State.locked),
    ('App e banca', '0 di 4 lezioni', _State.locked),
    ('Sicurezza e truffe', '0 di 3 lezioni', _State.locked),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleBackButton(onDark: true),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: AppColors.yellow, size: 22),
                            const SizedBox(width: 6),
                            Text(
                              '420',
                              style: GoogleFonts.rubik(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Telefono',
                    style: GoogleFonts.rubik(
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '4 lezioni completate su 16',
                    style: GoogleFonts.rubik(
                        fontSize: 18, color: Colors.white.withValues(alpha: 0.85)),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: 4 / 16,
                      minHeight: 10,
                      backgroundColor: Colors.white24,
                      valueColor:
                      const AlwaysStoppedAnimation(AppColors.yellow),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(36)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                        children: [
                          Text(
                            'Il tuo percorso',
                            style: GoogleFonts.rubik(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                          ),
                          const SizedBox(height: 14),
                          for (final m in _modules)
                            _ModuleRow(
                              title: m.$1,
                              subtitle: m.$2,
                              state: m.$3,
                            ),
                        ],
                      ),
                    ),
                    AppBottomNav(
                      current: 1,
                      onTap: (i) => context.go('/home', extra: i),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleRow extends StatelessWidget {
  const _ModuleRow({
    required this.title,
    required this.subtitle,
    required this.state,
  });
  final String title;
  final String subtitle;
  final _State state;

  @override
  Widget build(BuildContext context) {
    final current = state == _State.current;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          _StatusDot(state: state),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                final msg = state == _State.locked
                    ? 'Completa prima le lezioni precedenti'
                    : '$title: in arrivo';
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(msg)));
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: current ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.rubik(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: current ? Colors.white : AppColors.ink,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: GoogleFonts.rubik(
                              fontSize: 16,
                              color: current ? Colors.white : AppColors.body,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: current ? Colors.white : AppColors.ink,
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

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.state});
  final _State state;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case _State.done:
        return Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
              color: AppColors.green, shape: BoxShape.circle),
          child: const Icon(Icons.check, size: 18, color: AppColors.ink),
        );
      case _State.current:
        return Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.yellow, width: 5),
          ),
        );
      case _State.locked:
        return Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
              color: Color(0xFFE3DDFF), shape: BoxShape.circle),
          child: const Icon(Icons.lock, size: 15, color: AppColors.primary),
        );
    }
  }
}