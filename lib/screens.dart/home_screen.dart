import 'package:flutter/material.dart';

import '../widgets/feature_card.dart';
import 'audio_screen.dart';
import 'device_info_screen.dart';
import 'gallery_screen.dart';
import 'map_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Features'),
        actions: [
          IconButton(
            tooltip: 'Profile',
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Device Features App',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Explore native device capabilities using Flutter.'),
          const SizedBox(height: 24),

          FeatureCard(
            title: 'Device Information',
            description: 'Show device model and operating system version.',
            icon: Icons.phone_android,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DeviceInfoScreen()),
              );
            },
          ),

          FeatureCard(
            title: 'Image Gallery',
            description: 'Pick multiple images from the device gallery.',
            icon: Icons.photo_library,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GalleryScreen()),
              );
            },
          ),

          FeatureCard(
            title: 'Google Map',
            description: 'Display Cairo Governorate with a marker.',
            icon: Icons.map,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MapScreen()),
              );
            },
          ),

          FeatureCard(
            title: 'Audio Recorder',
            description: 'Record and play a voice recording.',
            icon: Icons.mic,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AudioScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
