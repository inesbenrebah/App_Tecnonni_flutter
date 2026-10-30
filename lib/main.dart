import 'package:flutter/material.dart';
import 'package:app_tecnonni_flutter/core/router/app_router.dart';
import 'package:app_tecnonni_flutter/core/session.dart';
import 'package:app_tecnonni_flutter/core/theme/app_theme.dart';

void main() => runApp(const TecnonniApp());

class TecnonniApp extends StatelessWidget {
  const TecnonniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: Session.textScale,
      builder: (context, scale, _) {
        return MaterialApp.router(
          title: 'Tecnonni',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          routerConfig: appRouter,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.linear(scale)),
            child: child!,
          ),
        );
      },
    );
  }
}