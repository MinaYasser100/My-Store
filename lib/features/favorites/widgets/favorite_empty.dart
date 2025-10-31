import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

class FavoriteEmpty extends StatelessWidget {
  const FavoriteEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie.asset(
          //   'assets/animations/Favorite_heart.json',
          //   width: 200,
          //   height: 200,
          //   fit: BoxFit.fill,
          // ),
          const SizedBox(height: 20),
          const Text(
            'No favorites yet!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Start adding items to your favorites by tapping the heart icon on product you love!',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
