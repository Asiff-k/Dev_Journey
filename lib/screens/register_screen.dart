import 'package:dev_journey/main.dart';
import 'package:dev_journey/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _loading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; });

    try {
      await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        data: {'full_name': _fullNameController.text.trim()},
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar( content: Text('Success! Please check your email for a verification link.'), backgroundColor: Colors.green, ),
        );
        Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } on AuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar( content: Text(error.message), backgroundColor: Colors.red, ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar( content: Text('An unexpected error occurred.'), backgroundColor: Colors.red, ),
        );
      }
    }

    if (mounted) setState(() { _loading = false; });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C3E50), Color(0xFF4A6DA7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/images/logo.png', height: 80),
                  const SizedBox(height: 16),
                  const Text(
                    'Create Your Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      filled: true,
                      fillColor: Colors.white.withAlpha((0.1 * 255).toInt()),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      labelStyle: const TextStyle(color: Colors.white70),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter your full name' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      filled: true,
                      fillColor: Colors.white.withAlpha((0.1 * 255).toInt()),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      labelStyle: const TextStyle(color: Colors.white70),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value == null || !EmailValidator.validate(value) ? 'Please enter a valid email' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white.withAlpha((0.1 * 255).toInt()),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      labelStyle: const TextStyle(color: Colors.white70),
                      helperText: 'Must be at least 8 characters',
                      helperStyle: TextStyle(color: Colors.grey[400]),
                    ),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: (value) => value == null || value.length < 8 ? 'Password must be at least 8 characters' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      filled: true,
                      fillColor: Colors.white.withAlpha((0.1 * 255).toInt()),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      labelStyle: const TextStyle(color: Colors.white70),
                    ),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    validator: (value) => value != _passwordController.text ? 'Passwords do not match' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _loading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Create Account', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
