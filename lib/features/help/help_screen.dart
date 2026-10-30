import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';
import 'package:app_tecnonni_flutter/shared/widgets/circle_back_button.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  void _todo(BuildContext context, String what) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$what: in arrivo')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleBackButton(),
              const SizedBox(height: 20),
              Text(
                'Hai bisogno di aiuto?',
                style: GoogleFonts.rubik(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Siamo qui. Scegli come preferisci.',
                style: GoogleFonts.rubik(fontSize: 20, color: AppColors.body),
              ),
              const SizedBox(height: 20),
              _HelpCard(
                icon: Icons.phone_outlined,
                title: 'Parla con un volontario',
                subtitle: 'Ti richiamiamo noi',
                color: const Color(0xFF3B2A8C),
                iconBg: Colors.white.withValues(alpha: 0.25),
                textColor: Colors.white,
                onTap: () => _todo(context, 'Richiamata'),
              ),
              _HelpCard(
                icon: Icons.chat_bubble_outline,
                title: 'Scrivi un messaggio',
                subtitle: 'Rispondiamo il prima possibile',
                color: AppColors.yellow,
                iconBg: const Color(0xFFFFE7B3),
                textColor: AppColors.ink,
                onTap: () => _todo(context, 'Messaggio'),
              ),
              _HelpCard(
                icon: Icons.calendar_today_outlined,
                title: 'Vieni a un incontro',
                subtitle: 'Ti aiutiamo di persona',
                color: AppColors.green,
                iconBg: const Color(0xFFCBF1D6),
                textColor: AppColors.ink,
                onTap: () => context.go('/home', extra: 2),
              ),
              const SizedBox(height: 12),
              Text(
                'Domande frequenti',
                style: GoogleFonts.rubik(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 12),
              _FaqRow('Come ingrandisco le lettere?',
                  onTap: () => context.push('/settings')),
              _FaqRow('Come ascolto una lezione?',
                  onTap: () => _todo(context, 'Risposta')),
              _FaqRow('Ho ricevuto un messaggio strano',
                  onTap: () => _todo(context, 'Risposta')),
            ],
          ),
        ),
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  const _HelpCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.iconBg,
    required this.textColor,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color iconBg;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: textColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.rubik(fontSize: 16, color: textColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqRow extends StatelessWidget {
  const _FaqRow(this.text, {required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.rubik(fontSize: 18, color: AppColors.ink),
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.body),
          ],
        ),
      ),
    );
  }
}