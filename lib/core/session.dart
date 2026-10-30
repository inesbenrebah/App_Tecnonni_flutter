import 'package:flutter/foundation.dart';

class Session {
  static String name = '';
  static String city = 'Pordenone';
  static bool readAloud = true;
  static bool subtitles = true;
  static bool reminders = true;
  static int voiceSpeed = 0; // 0 = lenta, 1 = normale, 2 = veloce
  static int appearance = 0; // 0 = chiaro, 1 = scuro, 2 = automatico
  static final textScale = ValueNotifier<double>(1.0);
}