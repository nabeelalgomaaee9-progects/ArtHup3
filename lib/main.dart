import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controllers/auth_controller.dart';
import 'localization/app_translations.dart';
import 'views/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://asxsshlqbuxnoerhhdiv.supabase.co",
    anonKey: "sb_publishable_mOwmFaalGm03VPax0Wo5UA_og6iioSn",
  );

  // ✅ Create AuthController once
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: const Locale("en"),
      fallbackLocale: const Locale("en"),

      home: const AuthWrapper(),
    );
  }
}
