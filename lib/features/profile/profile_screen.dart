import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/session.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';
import 'package:app_tecnonni_flutter/shared/widgets/circle_back_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = Session.name.isEmpty ? 'Maria' : Session.name;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: AppColors.yellow,
                    child: Text(
                      name[0].toUpperCase(),
                      style: GoogleFonts.rubik(
                        fontSize: 44,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  const CircleBackButton(),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                name,
                style: GoogleFonts.rubik(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              Text(
                '${Session.city} • Livello 3',
                style: GoogleFonts.rubik(fontSize: 18, color: AppColors.body),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  _Stat(value: '420', label: 'punti'),
                  SizedBox(width: 10),
                  _Stat(value: '5', label: 'giorni di fila'),
                  SizedBox(width: 10),
                  _Stat(value: '4', label: 'lezioni'),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'I tuoi traguardi',
                  style: GoogleFonts.rubik(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Badge(
                      icon: Icons.chat_bubble_outline,
                      label: 'Primo messaggio',
                      color: AppColors.yellow),
                  _Badge(
                      icon: Icons.local_fire_department_outlined,
                      label: '5 giorni di fila',
                      color: AppColors.coral),
                  _Badge(
                      icon: Icons.shield_outlined,
                      label: 'Anti-truffa',
                      color: AppColors.green),
                  _Badge(
                      icon: Icons.lock_outline,
                      label: 'Primo incontro',
                      color: Color(0xFFE3DDFF),
                      locked: true),
                ],
              ),
              const SizedBox(height: 20),
              _MenuRow(
                icon: Icons.settings_outlined,
                label: 'Impostazioni',
                onTap: () => context.push('/settings'),
              ),
              _MenuRow(
                icon: Icons.help_outline,
                label: 'Aiuto',
                onTap: () => context.push('/help'),
              ),
              _MenuRow(
                icon: Icons.logout,
                label: 'Esci',
                onTap: () {
                  // TODO: sign out from the backend
                  Session.name = '';
                  context.go('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.rubik(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(fontSize: 15, color: AppColors.body),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.icon,
    required this.label,
    required this.color,
    this.locked = false,
  });
  final IconData icon;
  final String label;
  final Color color;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(
              icon,
              size: 28,
              color: locked ? AppColors.body : AppColors.ink,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(
              fontSize: 14,
              color: locked ? AppColors.body : AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE3DDFF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.rubik(fontSize: 20, color: AppColors.ink),
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.body),
          ],
        ),
      ),
    );
  }
}