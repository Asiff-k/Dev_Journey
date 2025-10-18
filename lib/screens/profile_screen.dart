import 'package:dev_journey/main.dart';
import 'package:dev_journey/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'User';
  String _userEmail = 'user@example.com';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final fullName = user.userMetadata?['full_name'] as String?;
      final email = user.email;
      setState(() {
        _userName = (fullName != null && fullName.isNotEmpty) ? fullName : 'User';
        _userEmail = email ?? 'user@example.com';
      });
    }
  }

  Future<void> _logout() async {
    await supabase.auth.signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('Profile & Settings'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildUserInfo(),
            const SizedBox(height: 24),
            const Text(
              '"Keep up the great work!"',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            _buildMenuButton(icon: Icons.edit, text: 'Edit Profile', onTap: () {}),
            const SizedBox(height: 16),
            _buildMenuButton(icon: Icons.lock_outline, text: 'Change Password', onTap: () {}),
            const SizedBox(height: 16),
            _buildMenuButton(icon: Icons.logout, text: 'Logout', onTap: _logout, isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.school, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          _userName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          _userEmail,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    final color = isLogout ? Colors.redAccent : Colors.blueAccent;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.1 * 255).toInt()),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isLogout ? Colors.redAccent : Colors.black87,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
