import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> _authenticate() async {
    try {
      final bool isSupported = await _localAuthentication.isDeviceSupported();

      if (!isSupported) {
        _showMessage('Biometric authentication is not supported.');
        return;
      }

      final bool isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Authenticate to access your profile',
        biometricOnly: true,
      );

      if (!mounted) {
        return;
      }

      if (isAuthenticated) {
        _showProfile();
      } else {
        _showMessage('Authentication failed.');
      }
    } catch (error) {
      if (!mounted) {
        return;
      }

      _showMessage('Authentication error: $error');
    }
  }

  void _showProfile() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Mohammed Nasser',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('mohammed@example.com'),
            ],
          ),
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Secure Profile')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _authenticate,
          icon: const Icon(Icons.fingerprint),
          label: const Text('Unlock Profile'),
        ),
      ),
    );
  }
}
