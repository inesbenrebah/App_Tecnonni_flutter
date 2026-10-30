import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/session.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';
import 'package:app_tecnonni_flutter/shared/widgets/app_button.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  static const _cities = [
    'Pordenone',
    'Udine',
    'Trieste',
    'Gorizia',
    'Cividale del Friuli',
  ];

  String _city = Session.city;
  double _scale = Session.textScale.value;
  bool _readAloud = Session.readAloud;

  void _continue() {
    Session.city = _city;
    Session.textScale.value = _scale;
    Session.readAloud = _readAloud;
    // TODO: save these choices in the backend
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final name = Session.name.isEmpty ? '' : ', ${Session.name}';
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quasi pronti$name!',
                        style: GoogleFonts.rubik(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Due scelte veloci. Le puoi cambiare quando vuoi.',
                        style: GoogleFonts.rubik(
                            fontSize: 20, color: AppColors.body),
                      ),
                      const SizedBox(height: 28),
                      Text('In quale città abiti?', style: _section()),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          for (final c in _cities)
                            _CityChip(
                              label: c,
                              selected: c == _city,
                              onTap: () => setState(() => _city = c),
                            ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Text('Quanto grande vuoi il testo?', style: _section()),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _SizeBox(
                            label: 'Normale',
                            fontSize: 18,
                            selected: _scale == 1.0,
                            onTap: () => setState(() {
                              _scale = 1.0;
                              Session.textScale.value = 1.0;
                            }),
                          ),
                          const SizedBox(width: 10),
                          _SizeBox(
                            label: 'Grande',
                            fontSize: 24,
                            selected: _scale == 1.15,
                            onTap: () => setState(() {
                              _scale = 1.15;
                              Session.textScale.value = 1.15;
                            }),
                          ),
                          const SizedBox(width: 10),
                          _SizeBox(
                            label: 'Molto grande',
                            fontSize: 30,
                            selected: _scale == 1.3,
                            onTap: () => setState(() {
                              _scale = 1.3;
                              Session.textScale.value = 1.3;
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
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
                                color: AppColors.green,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(Icons.volume_up_outlined,
                                  color: AppColors.ink),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                'Leggimi i testi ad alta voce',
                                style: GoogleFonts.rubik(
                                    fontSize: 18, color: AppColors.ink),
                              ),
                            ),
                            Switch(
                              value: _readAloud,
                              activeColor: Colors.white,
                              activeTrackColor: AppColors.primary,
                              onChanged: (v) => setState(() => _readAloud = v),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AppButton(label: 'Continua', onPressed: _continue),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _section() => GoogleFonts.rubik(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );
}

class _CityChip extends StatelessWidget {
  const _CityChip({
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
            color: selected ? Colors.white : AppColors.ink,
          ),
        ),
      ),
    );
  }
}

class _SizeBox extends StatelessWidget {
  const _SizeBox({
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
              height: 76,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFFE3DDFF) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? AppColors.primary : const Color(0xFFD9D0FF),
                  width: selected ? 3 : 2,
                ),
              ),
              // MediaQuery override so "Aa" keeps its own size
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