import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/session.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';
import 'package:app_tecnonni_flutter/shared/widgets/choice_widgets.dart';
import 'package:app_tecnonni_flutter/shared/widgets/circle_back_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _setScale(double v) {
    setState(() => Session.textScale.value = v);
    // TODO: save in the backend
  }

  @override
  Widget build(BuildContext context) {
    final scale = Session.textScale.value;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleBackButton(),
                  const SizedBox(width: 16),
                  Text(
                    'Impostazioni',
                    style: GoogleFonts.rubik(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _Section(
                title: 'Grandezza del testo',
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizeOption(
                      label: 'Normale',
                      fontSize: 18,
                      selected: scale == 1.0,
                      onTap: () => _setScale(1.0),
                    ),
                    const SizedBox(width: 10),
                    SizeOption(
                      label: 'Grande',
                      fontSize: 24,
                      selected: scale == 1.15,
                      onTap: () => _setScale(1.15),
                    ),
                    const SizedBox(width: 10),
                    SizeOption(
                      label: 'Molto grande',
                      fontSize: 30,
                      selected: scale == 1.3,
                      onTap: () => _setScale(1.3),
                    ),
                  ],
                ),
              ),

              _Section(
                child: Column(
                  children: [
                    _SwitchRow(
                      label: 'Leggi i testi ad alta voce',
                      value: Session.readAloud,
                      onChanged: (v) =>
                          setState(() => Session.readAloud = v),
                    ),
                    _SwitchRow(
                      label: 'Sottotitoli nei video',
                      value: Session.subtitles,
                      onChanged: (v) =>
                          setState(() => Session.subtitles = v),
                    ),
                    _SwitchRow(
                      label: 'Promemoria per gli incontri',
                      value: Session.reminders,
                      onChanged: (v) =>
                          setState(() => Session.reminders = v),
                    ),
                  ],
                ),
              ),

              _Section(
                title: 'Velocità della voce',
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final e in ['Lenta', 'Normale', 'Veloce'].indexed)
                      PillChoice(
                        label: e.$2,
                        selected: Session.voiceSpeed == e.$1,
                        onTap: () => setState(() => Session.voiceSpeed = e.$1),
                      ),
                  ],
                ),
              ),

              _Section(
                title: 'Aspetto',
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final e in ['Chiaro', 'Scuro', 'Automatico'].indexed)
                      PillChoice(
                        label: e.$2,
                        selected: Session.appearance == e.$1,
                        onTap: () => setState(() => Session.appearance = e.$1),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({this.title, required this.child});
  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: GoogleFonts.rubik(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 12),
          ],
          child,
        ],
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.rubik(fontSize: 18, color: AppColors.ink),
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
