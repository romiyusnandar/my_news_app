import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_2/views/introduction_page.dart';
import 'package:my_news_2/views/login_page.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const IntroductionPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/news logo.png',
                        width: 100,
                      ),
                      const SizedBox(height: 20),
                      GradientText(
                        'News Hive',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1A1A1A)
                        ),
                        gradientType: GradientType.linear,
                        colors: [
                          Color(0xFF2D2E82),
                          Color(0xFF1A1A1A),
                        ],
                      )
                    ],
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: CircularProgressIndicator(
                strokeWidth: 4,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2D2E82)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}