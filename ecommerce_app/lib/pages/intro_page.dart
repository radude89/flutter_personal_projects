
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(
                'lib/images/nike_1.png',
                height: 240,
              ),
            ),
            const SizedBox(height: 48),

            const Text(
              'Just Do It',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                )
            ),

            const SizedBox(height: 24),

            const Text(
              'Subtitle',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
