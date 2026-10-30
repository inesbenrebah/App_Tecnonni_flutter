import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/session.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';
import 'package:app_tecnonni_flutter/shared/widgets/app_button.dart';
import 'package:app_tecnonni_flutter/shared/widgets/app_text_field.dart';
import 'package:app_tecnonni_flutter/shared/widgets/circle_back_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (_email.text.trim().isEmpty || _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Scrivi email e password')),
      );
      return;
    }
    // TODO: real login with the backend
    if (Session.name.isEmpty) Session.name = 'Maria';
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleBackButton(),
                      const SizedBox(height: 24),
                      Text(
                        'Bentornata!',
                        style: GoogleFonts.rubik(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Entra per continuare a imparare.',
                        style: GoogleFonts.rubik(
                            fontSize: 20, color: AppColors.body),
                      ),
                      const SizedBox(height: 28),
                      AppTextField(
                        label: 'Email o numero di telefono',
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'Password',
                        controller: _password,
                        isPassword: true,
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {}, // TODO: forgot password
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(48, 48),
                        ),
                        child: Text(
                          'Ho dimenticato la password',
                          style: GoogleFonts.rubik(
                              fontSize: 18, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppButton(label: 'Entra', onPressed: _submit),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Non hai un account?',
                    style: GoogleFonts.rubik(
                        fontSize: 18, color: AppColors.body),
                  ),
                  TextButton(
                    onPressed: () => context.go('/signup'),
                    child: Text(
                      'Registrati',
                      style: GoogleFonts.rubik(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}