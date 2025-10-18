import 'package:dev_journey/main.dart';
import 'package:dev_journey/screens/login_screen.dart';
import 'package:dev_journey/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final session = supabase.auth.currentSession;
    if (session != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6B73FF), Color(0xFF000DFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/logo.png'),
                width: 120,
              ),
              SizedBox(height: 20),
              Text(
                'DevJourney',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              Text(
                'Learn. Build. Grow.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
