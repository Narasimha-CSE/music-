import 'package:flutter/material.dart';
import 'package:music/MusicHomePage.dart';

void main() {
  runApp(const Premiumpage());
}

class Premiumpage extends StatelessWidget {
  const Premiumpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PremiumPage(),
    );
  }
}

class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;


  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Go Premium',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Enjoy your music without limits.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 400,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: subscriptionTiers.length,
                  itemBuilder: (context, index) {
                    final isCurrentPage = index == _currentPage;
                    return AnimatedScale(
                      scale: isCurrentPage ? 1.0 : 0.9,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child: SubscriptionCard(
                        tier: subscriptionTiers[index],
                        isCurrentPage: isCurrentPage,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Subscription Benefits',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...subscriptionBenefits.map((benefit) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                benefit,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final Map<String, dynamic> tier;
  final bool isCurrentPage;

  const SubscriptionCard({
    required this.tier,
    required this.isCurrentPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final title = tier['title'];
    final price = tier['price'];
    final features = tier['features'];
    final isRecommended = tier['recommended'];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: isCurrentPage ? const Color(0xFF1E1E1E) : const Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(20),
        border: isRecommended
            ? Border.all(color: Colors.greenAccent, width: 2)
            : null,
        boxShadow: isCurrentPage
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ]
            : null,
      ),
      child: Stack(
        children: [
          if (isRecommended)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Recommended',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                ...features.map<Widget>((feature) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        const Icon(Icons.check, color: Colors.white70, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: isRecommended ? Colors.greenAccent : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Choose Plan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> subscriptionTiers = [
  {
    'title': 'Individual',
    'price': '₹119/mo',
    'features': [
      'Ad-free music',
      'Downloadable songs',
      'Listen offline',
      'High-quality audio',
    ],
    'recommended': false,
  },
  {
    'title': 'Family',
    'price': '₹179/mo',
    'features': [
      'Up to 6 accounts',
      'Ad-free music',
      'Downloadable songs',
      'Family Mix playlist',
    ],
    'recommended': true,
  },
  {
    'title': 'Student',
    'price': '₹59/mo',
    'features': [
      'Ad-free music',
      'Downloadable songs',
      'Listen offline',
      'Discount for eligible students',
    ],
    'recommended': false,
  },
];

final List<String> subscriptionBenefits = [
  'Enjoy millions of songs and podcasts, with no interruptions.',
  'Download your favorite tracks and listen offline.',
  'Access high-quality audio for a richer listening experience.',
  'Skip unlimited songs and create your perfect playlists.',
  'Listen to your music on any device, anywhere you go.',
];