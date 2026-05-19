import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsi/controllers/auth_controller.dart';
import 'package:responsi/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFFE08295),
              child: Icon(
                Icons.person,
                size: 55,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Center(
              child: Text(
                authController.username.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildProfileItem(
            icon: Icons.star_outline,
            label: 'Kesan',
            value: 'Susah sekali mas.',
          ),
          _buildProfileItem(
            icon: Icons.chat_bubble_outline,
            label: 'Pesan',
            value: 'Ga tau lagi pusing.',
          ),
          _buildProfileItem(
            icon: Icons.gavel_outlined,
            label: 'Kritik',
            value: 'Ga tau juga.',
          ),
          _buildProfileItem(
            icon: Icons.lightbulb_outline,
            label: 'Saran',
            value: 'Tida tau lagi.',
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () async {
                await authController.logout();
                Get.offAll(() => const LoginPage());
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFE08295)),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}