import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:dev_journey/main.dart';
import 'package:dev_journey/screens/login_screen.dart';
import 'package:dev_journey/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<AuthState>? _authStateSubscription;

  get appLink => null;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks(); // Handle links if app is already running
    _getInitialLink();    // Handle link if app starts from it
    _setupAuthListener(); // Listen for auth changes (most reliable trigger)
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel(); // Clean up listener
    super.dispose();
  }

  /// Checks for the initial link the app was opened with.
  Future<void> _getInitialLink() async {
    final appLinks = AppLinks();
    try {
      final initialUri = await appLink.getInitialAppLink();
      if (initialUri != null) {
        print('Received initial link: $initialUri');
        // Let Supabase handle the authentication callback.
        // The auth listener below will handle navigation.
        supabase.auth.getSessionFromUrl(initialUri);
      }
    } catch (e) {
      print('Error getting initial link: $e');
    }
  }

  /// Handles incoming links when the app is already open in the background.
  void _handleIncomingLinks() {
    final appLinks = AppLinks();
    appLinks.uriLinkStream.listen((uri) {
      if (mounted) {
        print('Received link while app is running: $uri');
        // Let Supabase handle the authentication callback.
        // The auth listener below will handle navigation.
        supabase.auth.getSessionFromUrl(uri);
      }
    }).onError((err) {
      if (mounted) {
        print('Error handling incoming link: $err');
      }
    });
  }

  /// Sets up the listener that reacts to authentication changes.
  void _setupAuthListener() {
    // Wait until the first frame is rendered to avoid navigating during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Listen for changes in authentication state
      _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
        final Session? session = data.session;
        if (!mounted) return; // Check if the widget is still in the tree

        if (session != null) {
          // If user is signed in (could be from stored session or deep link verification)
          print("Auth Listener: User signed IN");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottomNavBar()),
          );
        } else {
          // If user is signed out or session expired
          print("Auth Listener: User signed OUT");
          // Avoid navigating immediately if the app just started.
          // Give splash screen some time unless already navigated.
          if (ModalRoute.of(context)?.isCurrent ?? false) {
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted && supabase.auth.currentSession == null) { // Double check session status
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            });
          }
        }
      });

      // Also check the initial session when the listener is first set up
      final initialSession = supabase.auth.currentSession;
      if (initialSession == null) {
        // If no initial session, wait for splash duration then potentially navigate
        // This handles the case where the auth listener doesn't fire immediately
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted && supabase.auth.currentSession == null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Same UI as before
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