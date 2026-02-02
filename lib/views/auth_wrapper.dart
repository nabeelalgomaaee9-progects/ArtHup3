import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_view.dart';
import 'navigation_view.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    // ✅ إذا المستخدم مسجل دخول
    if (session != null) {
      return const NavigationView();
    }

    // ✅ إذا غير مسجل
    return LoginView();
  }
}
