import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/session.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:app_tecnonni_flutter/shared/widgets/app_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.initialTab = 0});
  final int initialTab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _tab = widget.initialTab;

  static const _titles = ['Home', 'Lezioni', 'Incontri', 'Classifica'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: switch (_tab) {
                0 => const _HomeTab(),
                1 => const _LessonsTab(),
                _ => Center(
                  child: Text(
                    _titles[_tab],
                    style: GoogleFonts.rubik(fontSize: 28),
                  ),
                ),
              },
            ),
            AppBottomNav(
              current: _tab,
              onTap: (i) => setState(() => _tab = i),
            ),
          ],
        ),
      ),
    );
  }
}

// Temporary "Lezioni" tab: shows the 4 topics, Telefono is ready
class _LessonsTab extends StatelessWidget {
  const _LessonsTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: 68,
          child: ElevatedButton(
            onPressed: () => context.push('/phone'),
            child: const Text('Apri il percorso Telefono'),
          ),
        ),
      ),
    );
  }
}
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final name = Session.name.isEmpty ? 'Maria' : Session.name;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Buongiorno,',
                        style: GoogleFonts.rubik(
                            fontSize: 18, color: AppColors.body)),
                    Text('$name!',
                        style: GoogleFonts.rubik(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        )),
                  ],
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.yellow, size: 22),
                    const SizedBox(width: 6),
                    Text('420',
                        style: GoogleFonts.rubik(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        )),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.yellow,
                child: Text(
                  name[0].toUpperCase(),
                  style: GoogleFonts.rubik(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Continue lesson card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF3B2A8C),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Continua la lezione',
                          style: GoogleFonts.rubik(
                              fontSize: 16, color: AppColors.yellow)),
                      const SizedBox(height: 4),
                      Text('Mandare un messaggio',
                          style: GoogleFonts.rubik(
                            fontSize: 22,
                            height: 1.2,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          )),
                      const SizedBox(height: 4),
                      Text('Telefono • Passo 2 di 5',
                          style: GoogleFonts.rubik(
                              fontSize: 16, color: Colors.white70)),
                      const SizedBox(height: 14),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: 0.4,
                          minHeight: 10,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation(
                              AppColors.yellow),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 68,
                  height: 68,
                  decoration: const BoxDecoration(
                    color: AppColors.yellow,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow_rounded,
                      size: 40, color: AppColors.ink),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text('Cosa vuoi imparare?',
              style: GoogleFonts.rubik(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              )),
          const SizedBox(height: 14),

          Row(
            children:  [
              Expanded(
                child: _CategoryTile(
                  label: 'Telefono',
                  icon: Icons.smartphone,
                  color: AppColors.primary,
                  iconBg: Color(0x33FFFFFF),
                  textColor: Colors.white,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _CategoryTile(
                  label: 'Computer',
                  icon: Icons.laptop,
                  color: AppColors.yellow,
                  iconBg: Color(0x66FFFFFF),
                  textColor: AppColors.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              Expanded(
                child: _CategoryTile(
                  label: 'Televisione',
                  icon: Icons.tv,
                  color: AppColors.coral,
                  iconBg: Color(0x66FFFFFF),
                  textColor: AppColors.ink,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _CategoryTile(
                  label: 'Difenditi dalle truffe',
                  icon: Icons.shield_outlined,
                  color: AppColors.green,
                  iconBg: Color(0x66FFFFFF),
                  textColor: AppColors.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Next meetup
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.coral,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('SAB',
                          style: GoogleFonts.rubik(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          )),
                      Text('24',
                          style: GoogleFonts.rubik(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          )),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Prossimo incontro',
                          style: GoogleFonts.rubik(
                              fontSize: 16, color: AppColors.body)),
                      Text('${Session.city} • ore 10:00',
                          style: GoogleFonts.rubik(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          )),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.ink),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.label,
    required this.icon,
    required this.color,
    required this.iconBg,
    required this.textColor,
  });

  final String label;
  final IconData icon;
  final Color color;
  final Color iconBg;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: textColor, size: 24),
          ),
          Text(
            label,
            style: GoogleFonts.rubik(
              fontSize: 20,
              height: 1.1,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}