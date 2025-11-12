import 'package:flutter/material.dart';

void main() {
  runApp(const AboutMyStoreScreen());
}

class AboutMyStoreScreen extends StatelessWidget {
  const AboutMyStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'About My Store',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF4A4A4A),
            height: 1.5,
          ),
        ),
      ),
      home: const AboutMyStore(),
    );
  }
}

class AboutMyStore extends StatelessWidget {
  const AboutMyStore({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0D2857);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primaryColor, size: 20),
          onPressed: () {},
        ),
        title: const Text(
          'About My Store',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoCard(
            icon: Icons.favorite,
            title: 'Welcome to My Store',
            content:
                'We\'re passionate about bringing you the freshest, highest-quality produce directly from local farms to your table. Our commitment to sustainability and supporting local communities drives everything we do.',
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            icon: Icons.eco,
            title: 'Our Mission',
            content:
                'To create a sustainable food system that connects conscious consumers with local farmers, promoting fresh, organic produce while supporting agricultural communities.',
            bullets: const [
              'Sourced directly from local farms',
              '100% organic and pesticide-free',
              'Supporting sustainable farming practices',
            ],
          ),
          const SizedBox(height: 16),
          _buildValuesCard(),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    List<String>? bullets,
  }) {
    const Color primaryColor = Color(0xFF0D2857);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withAlpha(13),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: primaryColor.withAlpha(26),
                child: Icon(icon, color: primaryColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4A4A4A),
              height: 1.6,
            ),
          ),
          if (bullets != null) ...[
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: bullets
                  .map(
                    (b) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.circle, size: 6, color: primaryColor),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              b,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF4A4A4A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildValuesCard() {
    const Color primaryColor = Color(0xFF0D2857);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withAlpha(13),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Values',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 18),

          // العمودين العموديين متوازيين
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _buildValueItem(
                    icon: Icons.eco_outlined,
                    title: 'Sustainability',
                    subtitle: 'Eco-friendly practices',
                  ),
                  const SizedBox(height: 20),
                  _buildValueItem(
                    icon: Icons.people_outline,
                    title: 'Community',
                    subtitle: 'Supporting local farmers',
                  ),
                ],
              ),
              Column(
                children: [
                  _buildValueItem(
                    icon: Icons.favorite_outline,
                    title: 'Quality',
                    subtitle: 'Fresh, premium produce',
                  ),
                  const SizedBox(height: 20),
                  _buildValueItem(
                    icon: Icons.location_on_outlined,
                    title: 'Local',
                    subtitle: 'Sourced nearby',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValueItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    const Color primaryColor = Color(0xFF0D2857);
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: primaryColor.withAlpha(20),
          child: Icon(icon, color: primaryColor, size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF7B7B7B),
          ),
        ),
      ],
    );
  }
}
