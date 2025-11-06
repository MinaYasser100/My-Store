import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/utils/constant.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';
import 'package:my_store/core/model/user_model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _userHiveHelper = UserHiveHelper();

  @override
  Widget build(BuildContext context) {
    // Get user info from Hive
    final UserModel? user = _userHiveHelper.getUser(ConstantVariable.uId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF0D1C3C), width: 2.5),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'My Profile',
              style: TextStyle(
                color: Color(0xFF0D1C3C),
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: const Color(0xFF0D1C3C),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16),

            // 🧠 Dynamic Welcome Card
            _buildCard(
              icon: Icons.person,
              title: user != null
                  ? 'Welcome, ${user.firstName} ${user.lastName} !'
                  : 'Welcome!',
              subtitle: user?.email ?? 'No email available',
              isClickable: false,
            ),

            const SizedBox(height: 10),

            // Personal Info
            _buildCard(
              title: 'Personal Information',
              subtitle: 'Manage your account details',
              onTap: () {
                context.push(Routes.personalInfoView);
              },
            ),

            // Saved Addresses
            _buildCard(
              title: 'Saved Addresses',
              subtitle: 'Manage delivery addresses',
              onTap: () {
                context.push(Routes.savedAddressesView);
              },
            ),

            // Help & Support
            _buildCard(
              title: 'Help & Support',
              subtitle: 'Get help with your account',
              onTap: () {
                context.push(Routes.helpSupportView);
              },
            ),

            // About
            _buildCard(
              title: 'About My Store',
              subtitle: 'Learn more about us',
              onTap: () {},
            ),

            const SizedBox(height: 16),

            // Sign Out Button
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.redAccent),
                foregroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                // Clear Hive user and navigate to login if needed
                _userHiveHelper.deleteUser(ConstantVariable.uId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signed out successfully')),
                );
                context.go('/login');
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 24),
            Image.asset('assets/images/logo.png', height: 40),
            const SizedBox(height: 8),
            const Text(
              'My Store App v1.0',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// ✅ Reusable Card Builder
  Widget _buildCard({
    IconData? icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    bool isClickable = true,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.black.withOpacity(0.05),
      child: ListTile(
        leading: icon != null
            ? CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFF5F6FA),
                child: Icon(icon, color: const Color(0xFF0D1C3C)),
              )
            : null,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF0D1C3C),
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: isClickable
            ? const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
