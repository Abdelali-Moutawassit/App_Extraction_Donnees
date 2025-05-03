import 'package:adria_app_styles/Pages/home_screen.dart';
import 'package:adria_app_styles/Pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(MyApp(showOnboarding: !seenOnboarding));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;

  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KYC App',
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const HomeScreen(),
      },
      home: showOnboarding ? const OnboardingPage() : const HomeScreen(),
      // home: HomeScreen(),
    );
  }
}
