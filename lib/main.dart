import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram/firebase_options.dart';
import 'package:instagram/pages/home_page/home_page.dart';
import 'package:instagram/pages/login_signup/login/login_page.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/custom_progress_indicator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor
      ),
      home: const AuthChecker(),
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          if (user == null) {
            return const LoginPage();
          } else {
            if (!user.emailVerified) {
              FirebaseAuth.instance.currentUser?.delete();
              return const LoginPage();
            } else {
              return const HomePage();
            }
          }
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomCircularProgressIndicator(
          loadingColor: Colors.amber,
          size: 100,
          message: "Waiting for firebase connection",
          messageColor: Colors.white,
        )
      ),
    );
  }
}