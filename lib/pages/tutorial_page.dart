import 'package:flutter/material.dart';
import 'package:pocket_mafia/components/rounded_rectangle_button.dart';
import 'package:pocket_mafia/models/tutorial.dart';
import 'package:pocket_mafia/pages/home_page.dart';
import 'package:pocket_mafia/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final PageController _pageController = PageController(keepPage: true);
  bool _isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 20),

              // App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('How To Play', style: theme.textTheme.titleMedium),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'SKIP',
                      style: theme.textTheme.labelMedium!.copyWith(
                        color: TextColors.secondaryText,
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: tutorialContent.length,
                  onPageChanged: (index) {
                    if (index == tutorialContent.length-1) {
                      setState(() {
                        _isLastPage = true;
                      });
                    } else {
                      setState(() {
                        _isLastPage = false;
                      });
                    }
                  },
                  itemBuilder: (_, index) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            tutorialContent[index].imagePath,
                            width: 60.w,
                          ),
                          // Offset
                          SizedBox(height: 60),
                          Text(
                            tutorialContent[index].title,
                            style: theme.textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          // Offset
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              tutorialContent[index].desc,
                              style: theme.textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: tutorialContent.length,
                effect: ExpandingDotsEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  expansionFactor: 4,
                  dotColor: TextColors.secondaryText,
                  activeDotColor: theme.colorScheme.onSecondary,
                ),
              ),
              RoundedRectangleButton(
                label: !_isLastPage ? 'NEXT' : 'DONE',
                iconData: !_isLastPage ? Icons.arrow_forward : Icons.check,
                onPressed: () {
                  if (!_isLastPage) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pop(context);
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
