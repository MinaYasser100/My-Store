import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/utils/colors.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme().whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsTheme().whiteColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorsTheme().primaryColor,
            size: 18,
          ),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Help & Support',
          style: TextStyle(
            color: ColorsTheme().primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(
              icon: Icons.support_agent_outlined,
              iconBg: ColorsTheme().primaryColor,
              title: "We're Here to Help",
              subtitle:
                  "Need assistance with your order or have questions about our products? Our support team is ready to help you with any inquiries.",
            ),
            const SizedBox(height: 12),
            _buildCard(
              icon: Icons.phone_in_talk_outlined,
              title: 'Phone Support',
              subtitle:
                  'Call us directly for immediate assistance with your orders or questions.',
              extraText: '+20 123 456 7890',
              extraTextColor: ColorsTheme().primaryColor,
            ),
            const SizedBox(height: 12),
            _buildCard(
              icon: Icons.email_outlined,
              title: 'Email Support',
              subtitle:
                  "Send us an email and we'll get back to you within 24 hours.",
              extraText: 'support@mystore.com',
              extraTextColor: ColorsTheme().primaryColor,
            ),
            const SizedBox(height: 12),
            _buildCard(
              icon: Icons.access_time,
              title: 'Support Hours',
              subtitle: 'Saturday - Thursday\n9:00 AM - 9:00 PM',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    Color iconBg = const Color.fromARGB(255, 13, 28, 60),
    String? extraText,
    Color? extraTextColor,
  }) {
    return Card(
      color: ColorsTheme().whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: iconBg,
                  radius: 18,
                  child: Icon(icon, color: ColorsTheme().whiteColor, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorsTheme().primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(color: ColorsTheme().blackColor, height: 1.4),
            ),
            if (extraText != null) ...[
              const SizedBox(height: 6),
              Text(
                extraText,
                style: TextStyle(
                  color: extraTextColor ?? ColorsTheme().grayColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
