import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/utils/constant.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';
import 'package:my_store/core/model/user_model/user_model.dart';
import 'package:my_store/features/profile/ui/custom_profile_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _userHiveHelper = UserHiveHelper();

  @override
  Widget build(BuildContext context) {
    // Get user info from Hive
    final UserModel? user = _userHiveHelper.getUser(ConstantVariable.uId);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomProfileAppBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16),

            // 🧠 Dynamic Welcome Card
            _buildCard(
              context: context,
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
              context: context,
              title: 'Personal Information',
              subtitle: 'Manage your account details',
              onTap: () {
                context.push(Routes.personalInfoView);
              },
            ),

            // Saved Addresses
            _buildCard(
              context: context,
              title: 'Saved Addresses',
              subtitle: 'Manage delivery addresses',
              onTap: () {
                context.push(Routes.savedAddressesView);
              },
            ),

            // Help & Support
            _buildCard(
              context: context,
              title: 'Help & Support',
              subtitle: 'Get help with your account',
              onTap: () {
                context.push(Routes.helpSupportView);
              },
            ),

            // About
            _buildCard(
              context: context,
              title: 'About My Store',
              subtitle: 'Learn more about us',
              onTap: () {
                context.push(Routes.about);
              },

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
            Text(
              'My Store App v1.0',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// ✅ Reusable Card Builder
  Widget _buildCard({
    required BuildContext context,
    IconData? icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    bool isClickable = true,
  }) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      shadowColor: Colors.black.withOpacity(0.05),
      child: ListTile(
        leading: icon != null
            ? CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withOpacity(0.2),
                child: Icon(icon, color: Theme.of(context).colorScheme.primary),
              )
            : null,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: isClickable
            ? Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
