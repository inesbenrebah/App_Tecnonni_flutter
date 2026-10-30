import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_tecnonni_flutter/core/session.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';
import 'package:app_tecnonni_flutter/shared/widgets/app_button.dart';
import 'package:app_tecnonni_flutter/shared/widgets/app_text_field.dart';
import 'package:app_tecnonni_flutter/shared/widgets/circle_back_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _accepted = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    String? error;
    if (_name.text.trim().isEmpty) {
      error = 'Scrivi come ti chiami';
    } else if (_email.text.trim().isEmpty) {
      error = 'Scrivi la tua email o il tuo telefono';
    } else if (_password.text.length < 8) {
      error = 'La password deve avere almeno 8 caratteri';
    } else if (!_accepted) {
      error = 'Devi accettare le condizioni d\'uso';
    }

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    // TODO: create the account with the backend
    Session.name = _name.text.trim();
    context.go('/setup');
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
                        'Crea il tuo account',
                        style: GoogleFonts.rubik(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Bastano tre cose.',
                        style: GoogleFonts.rubik(
                            fontSize: 20, color: AppColors.body),
                      ),
                      const SizedBox(height: 24),
                      AppTextField(label: 'Come ti chiami?', controller: _name),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'Email o numero di telefono',
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'Scegli una password',
                        controller: _password,
                        isPassword: true,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Almeno 8 caratteri. Scrivila su un foglio e tienila al sicuro.',
                        style: GoogleFonts.rubik(
                            fontSize: 16, color: AppColors.body),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () => setState(() => _accepted = !_accepted),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _accepted,
                              activeColor: AppColors.primary,
                              onChanged: (v) =>
                                  setState(() => _accepted = v ?? false),
                            ),
                            Expanded(
                              child: Text(
                                'Accetto le condizioni d\'uso e la privacy',
                                style: GoogleFonts.rubik(
                                    fontSize: 18, color: AppColors.ink),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppButton(label: 'Crea il mio account', onPressed: _submit),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hai già un account?',
                    style: GoogleFonts.rubik(
                        fontSize: 18, color: AppColors.body),
                  ),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: Text(
                      'Entra',
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
