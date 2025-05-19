import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:my_news_2/views/login_page.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final PageController _pageController = PageController();
  bool isLastPage = false;

  final List<Map<String, String>> _introductionData = [
    {
      'title': 'The World at Your Fingertips',
      'description': 'Get 24/7 on global news - from breaking politics to cultural trends, all in one place.',
      'image': 'assets/images/img intro 1.png',
    },
    {
      'title': 'Tailored to Your Curiosity',
      'description': 'Select your interests and receive handpicked stories. Technology, sports, or entertainment – we’ve got you covered',
      'image': 'assets/images/img intro 2.png',
    },
    {
      'title': 'Trusted Updates in Real-Time',
      'description': 'Instant alerts for breaking news, rigorously fact-checked by our editors before they reach you',
      'image': 'assets/images/img intro 3.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        isLastPage = _pageController.page?.round() == _introductionData.length - 1;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _introductionData.length,
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == _introductionData.length - 1;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the left
                        children: [
                          Center(
                            child: Image.asset(
                              _introductionData[index]['image']!,
                              height: MediaQuery.of(context).size.height * 0.35,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(
                            thickness: 2,
                            color: Color(0xFF2D2E82),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _introductionData[index]['title']!,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D2E82),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _introductionData[index]['description']!,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: _introductionData.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Color(0xFF2D2E82),
                              dotColor: Color(0xFF2D2E82).withOpacity(0.5),
                              dotHeight: 10,
                              dotWidth: 10,
                              spacing: 10,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    // Skip button (hidden on last page)
                    if (!isLastPage)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: _goToLogin,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Color(0xFF2D2E82)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Skip',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2D2E82),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Next/Get Started button
                    Expanded(
                      flex: isLastPage ? 2 : 1, // Full width on last page
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (isLastPage) {
                              _goToLogin();
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2D2E82),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            isLastPage ? 'Get Started' : 'Next',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}