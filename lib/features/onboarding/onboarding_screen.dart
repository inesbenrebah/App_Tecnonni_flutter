import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';
import 'package:app_tecnonni_flutter/shared/widgets/app_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _totalPages = 3;
  final _controller = PageController();
  int _page = 0;

  bool get _isLast => _page == _totalPages - 1;

  void _next() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  void _skip() {
    _controller.animateToPage(
      _totalPages - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            children: [
              // Dots + Salta
              SizedBox(
                height: 48,
                child: Row(
                  children: [
                    for (int i = 0; i < _totalPages; i++) _Dot(active: i == _page),
                    const Spacer(),
                    if (!_isLast)
                      TextButton(
                        onPressed: _skip,
                        child: Text(
                          'Salta',
                          style: GoogleFonts.rubik(
                            fontSize: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Slides
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (i) => setState(() => _page = i),
                  children: const [
                    _SlideWhatIsIt(),
                    _SlideLearning(),
                    _SlideNeverAlone(),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Bottom buttons
              if (!_isLast)
                AppButton(
                  label: 'Avanti',
                  icon: Icons.chevron_right,
                  onPressed: _next,
                )
              else ...[
                AppButton(
                  label: 'Crea il mio account',
                  onPressed: () => context.go('/signup'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => context.go('/login'),
                  style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
                  child: Text(
                    'Ho già un account',
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ---------- Dots ----------

class _Dot extends StatelessWidget {
  const _Dot({required this.active});
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(right: 8),
      width: active ? 36 : 12,
      height: 12,
      decoration: BoxDecoration(
        color: active ? AppColors.primary : const Color(0xFFD3CAFF),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

// ---------- Shared text styles ----------

TextStyle _title() => GoogleFonts.rubik(
  fontSize: 32,
  height: 1.2,
  fontWeight: FontWeight.w700,
  color: AppColors.ink,
);

TextStyle _subtitle() => GoogleFonts.rubik(
  fontSize: 20,
  height: 1.4,
  color: AppColors.body,
);

// ---------- Slide 1: A cosa serve ----------

class _SlideWhatIsIt extends StatelessWidget {
  const _SlideWhatIsIt();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PhoneIllustration(),
          const SizedBox(height: 32),
          Text('A cosa serve\nTecnononni?', style: _title()),
          const SizedBox(height: 16),
          Text(
            'Ti aiutiamo a usare telefono, computer e televisione. '
                'Impari con calma, un passo alla volta, quando vuoi tu.',
            style: _subtitle(),
          ),
        ],
      ),
    );
  }
}

class _PhoneIllustration extends StatelessWidget {
  const _PhoneIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFE7B3),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Phone
          Container(
            width: 126,
            height: 260,
            padding: const EdgeInsets.fromLTRB(10, 28, 10, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFF3B2A8C), width: 6),
            ),
            child: Column(
              children: [
                _bar(const Color(0xFFE3DDFF)),
                const SizedBox(height: 10),
                _bar(AppColors.yellow),
                const SizedBox(height: 10),
                _bar(AppColors.green),
              ],
            ),
          ),
          // Bubbles
          Positioned(
            left: 24,
            top: 60,
            child: _Bubble(
              text: 'Ciao!',
              color: AppColors.coral,
              textColor: AppColors.ink,
            ),
          ),
          Positioned(
            right: 20,
            bottom: 60,
            child: _Bubble(
              text: 'Ci penso io',
              color: AppColors.primary,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar(Color color) => Container(
    height: 38,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.text,
    required this.color,
    required this.textColor,
  });
  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Text(
        text,
        style: GoogleFonts.rubik(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}

// ---------- Slide 2: Impari a modo tuo ----------

class _SlideLearning extends StatelessWidget {
  const _SlideLearning();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Impari a modo tuo', style: _title()),
          const SizedBox(height: 8),
          Text('Ogni lezione è breve e chiara.', style: _subtitle()),
          const SizedBox(height: 20),
          const _FeatureCard(
            icon: Icons.menu_book_outlined,
            iconBg: AppColors.yellow,
            title: 'Lezioni passo per passo',
            subtitle: 'Una cosa alla volta, con immagini chiare',
          ),
          const _FeatureCard(
            icon: Icons.videocam_outlined,
            iconBg: AppColors.coral,
            title: 'Video facili da seguire',
            subtitle: 'Con sottotitoli e velocità lenta',
          ),
          const _FeatureCard(
            icon: Icons.volume_up_outlined,
            iconBg: AppColors.green,
            title: 'Ti leggiamo il testo',
            subtitle: 'Ascolta la voce se leggere è faticoso',
          ),
          const _FeatureCard(
            icon: Icons.help_outline,
            iconBg: Color(0xFFCBC2FF),
            title: 'Domande per metterti alla prova',
            subtitle: 'Senza ansia: puoi sempre riprovare',
          ),
        ],
      ),
    );
  }
}

// ---------- Slide 3: Non sei mai solo ----------

class _SlideNeverAlone extends StatelessWidget {
  const _SlideNeverAlone();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Non sei mai solo', style: _title()),
          const SizedBox(height: 8),
          Text('Impari insieme ad altre persone.', style: _subtitle()),
          const SizedBox(height: 20),
          const _FeatureCard(
            icon: Icons.location_on_outlined,
            iconBg: Color(0xFFFFE7B3),
            cardBg: AppColors.yellow,
            title: 'Incontri nella tua città',
            subtitle: 'Insegnanti volontari ti aspettano di persona.',
          ),
          const _FeatureCard(
            icon: Icons.emoji_events_outlined,
            iconBg: Color(0xFFCBF1D6),
            cardBg: AppColors.green,
            title: 'Punti e classifica',
            subtitle: 'Guadagna punti e sblocca nuove lezioni.',
          ),
          const _FeatureCard(
            icon: Icons.shield_outlined,
            iconBg: Color(0xFFFFD0C9),
            cardBg: AppColors.coral,
            title: 'Protetto dalle truffe',
            subtitle: 'Impari a riconoscerle e a difenderti.',
          ),
        ],
      ),
    );
  }
}

// ---------- Reusable card ----------

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    this.cardBg = Colors.white,
  });

  final IconData icon;
  final Color iconBg;
  final Color cardBg;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: AppColors.ink, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.rubik(
                    fontSize: 19,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.rubik(
                    fontSize: 16,
                    height: 1.3,
                    color: cardBg == Colors.white
                        ? AppColors.body
                        : AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}