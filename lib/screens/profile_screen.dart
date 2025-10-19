import 'package:dev_journey/main.dart';
import 'package:dev_journey/screens/login_screen.dart';
import 'package:dev_journey/screens/edit_profile_screen.dart';
import 'package:dev_journey/screens/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = '';
  String _userEmail = '';
  bool _isLoading = true; // Start loading

  @override
  void initState() {
    super.initState();
    _getUserData(); // Fetch data on init
  }

  Future<void> _getUserData() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        // Optional: Refresh session to get latest data
        // await supabase.auth.refreshSession();
        // final freshUser = supabase.auth.currentUser;

        final fullName = user.userMetadata?['full_name'] as String?;
        final email = user.email;
        if (mounted) {
          setState(() {
            _userName = (fullName != null && fullName.isNotEmpty) ? fullName : 'User';
            _userEmail = email ?? 'No Email Found';
          });
        }
      } else {
        // If user is null, might indicate logged out state, navigate to login
        _handleLogoutNavigation();
      }
    } catch (e) {
      print("Error fetching user data: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching profile: ${e.toString()}'), backgroundColor: Colors.red),
        );
        // Set defaults on error
        setState(() {
          _userName = 'User';
          _userEmail = 'Error loading email';
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Helper to navigate to login and remove history
  void _handleLogoutNavigation() {
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
      );
    }
  }


  Future<void> _logout() async {
    setState(() => _isLoading = true); // Show loading indicator during sign out
    try {
      await supabase.auth.signOut();
      _handleLogoutNavigation(); // Navigate after successful sign out
    } catch (e) {
      print("Error logging out: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error logging out: ${e.toString()}'), backgroundColor: Colors.red),
        );
        setState(() => _isLoading = false); // Stop loading indicator on error
      }
    }
    // No finally block needed here as navigation replaces the screen
  }

  void _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
    );
    if (result == true && mounted) {
      _getUserData(); // Refresh data if profile was updated
    }
  }

  void _navigateToChangePassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get theme

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _getUserData,
            tooltip: 'Refresh Profile',
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator( // Allow pull to refresh
        onRefresh: _getUserData,
        child: ListView( // Use ListView for potential future scrolling needs
          padding: const EdgeInsets.all(24.0),
          children: [
            _buildUserInfo(theme),
            const SizedBox(height: 24),
            Text(
              '"Keep up the great work!"',
              textAlign: TextAlign.center, // Center the quote
              style: theme.textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic, color: Colors.grey[600]),
            ),
            const SizedBox(height: 48),
            _buildMenuButton(
                icon: Icons.edit_note, // Changed icon
                text: 'Edit Profile',
                onTap: _navigateToEditProfile,
                theme: theme),
            const SizedBox(height: 16),
            _buildMenuButton(
                icon: Icons.lock_outline,
                text: 'Change Password',
                onTap: _navigateToChangePassword,
                theme: theme),
            const SizedBox(height: 16),
            _buildMenuButton(
                icon: Icons.logout_rounded, // Changed icon
                text: 'Logout',
                onTap: _logout,
                isLogout: true,
                theme: theme),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(ThemeData theme) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: theme.primaryColorLight, // Use a theme color variation
          child: Icon(Icons.school_outlined, size: 60, color: theme.primaryColorDark), // Use theme color variation
        ),
        const SizedBox(height: 16),
        Text(
          _userName,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold), // Use theme text style
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          _userEmail,
          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[700]), // Use theme text style
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required ThemeData theme, // Pass theme
    bool isLogout = false,
  }) {
    final color = isLogout ? Colors.redAccent : theme.primaryColor;
    final textColor = isLogout ? Colors.redAccent : Colors.black87;

    return Card( // Wrap in Card for consistent styling
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding( // Add padding inside InkWell
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: theme.textTheme.titleMedium?.copyWith( // Use theme text style
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16), // Lighter arrow
            ],
          ),
        ),
      ),
    );
  }
}