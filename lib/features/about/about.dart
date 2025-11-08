import 'package:flutter/material.dart';

class AboutMyStoreScreen extends StatelessWidget {
  const AboutMyStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color kPrimaryColor = Color(0xFF0D2857);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "About My Store",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Welcome Section
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.favorite, color: kPrimaryColor),
                      SizedBox(width: 8),
                      Text(
                        "Welcome to My Store 💚",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "At My Store, we’re dedicated to offering you the freshest and most natural products — straight from local farms to your home. We care deeply about sustainability, the environment, and the people who make it all possible.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Mission Section
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.eco, color: kPrimaryColor),
                      SizedBox(width: 8),
                      Text(
                        "Our Mission 🌱",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "We aim to build a sustainable food network that connects conscious customers with hardworking farmers, promoting organic products and protecting nature.",
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                  SizedBox(height: 12),
                  Text("• Fresh & healthy products always available"),
                  Text("• Locally sourced from trusted farms"),
                  Text("• 100% organic, pesticide-free produce"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Values Section
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.wb_sunny, color: kPrimaryColor),
                      SizedBox(width: 8),
                      Text(
                        "Our Values 🌾",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Values Grid
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      _ValueItem(
                        icon: Icons.eco_outlined,
                        title: "Sustainability",
                        subtitle: "Eco-friendly practices",
                      ),
                      _ValueItem(
                        icon: Icons.favorite_border,
                        title: "Quality",
                        subtitle: "Fresh, premium produce",
                      ),
                      _ValueItem(
                        icon: Icons.people_alt_outlined,
                        title: "Community",
                        subtitle: "Supporting local farmers",
                      ),
                      _ValueItem(
                        icon: Icons.location_on_outlined,
                        title: "Local",
                        subtitle: "Sourced nearby",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Footer
          const Center(
            child: Text(
              "© 2025 My Store. All rights reserved.",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ValueItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const Color kPrimaryColor = Color(0xFF0D2857);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: kPrimaryColor),
        Text(
          title,
          style: const TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.black54, fontSize: 13),
        ),
      ],
    );
  }
}
