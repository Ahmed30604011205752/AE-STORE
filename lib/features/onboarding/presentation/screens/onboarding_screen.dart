import 'package:ae_store/features/onboarding/data/models/onboarding_slide.dart';
import 'package:ae_store/features/onboarding/presentation/widgets/onboarding_continue_button.dart';
import 'package:ae_store/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:ae_store/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:ae_store/features/onboarding/presentation/widgets/onboarding_service_highlights.dart';
import 'package:ae_store/features/onboarding/presentation/widgets/onboarding_slide_content.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _continue() {
    if (_currentPage < OnboardingSlide.all.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
      return;
    }
    _showWelcomeMessage();
  }

  void _skip() {
    _pageController.animateToPage(
      OnboardingSlide.all.length - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  void _showWelcomeMessage() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Welcome to AE Store')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Column(
            children: [
              OnboardingHeader(onSkip: _skip),
              const SizedBox(height: 12),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: OnboardingSlide.all.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) => OnboardingSlideContent(
                    slide: OnboardingSlide.all[index],
                    index: index,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OnboardingPageIndicator(
                itemCount: OnboardingSlide.all.length,
                currentPage: _currentPage,
              ),
              const SizedBox(height: 16),
              OnboardingContinueButton(
                onPressed: _continue,
                isLastPage: _currentPage == OnboardingSlide.all.length - 1,
              ),
              const SizedBox(height: 14),
              const OnboardingServiceHighlights(),
            ],
          ),
        ),
      ),
    );
  }
}
