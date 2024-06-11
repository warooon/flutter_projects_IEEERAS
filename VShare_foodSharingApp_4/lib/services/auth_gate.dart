import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:vshare/pages/login_or_register_page.dart";

import "../pages/main_page.dart";

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainPage();
            } else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
