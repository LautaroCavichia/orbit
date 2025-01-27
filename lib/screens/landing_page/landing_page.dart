import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:orbit/screens/landing_page/animated_background.dart';
import 'package:orbit/screens/landing_page/animated_subtitle.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _bounceAnimation;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToNextSection() {
    _scrollController.animateTo(
      MediaQuery.of(context).size.height,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          children: [
            const AnimatedBackground(),

            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: SafeArea(
                      child: Column(
                        children: [
                          const Spacer(),

                          // Title with your original entrance animation
                          Image.asset(
                            'logo.png',
                            width: 500,
                          )
                              .animate()
                              .fadeIn(
                                delay: const Duration(milliseconds: 800),
                                curve: Curves.easeOutCubic,
                              )
                              .slideY(begin: -0.2),

                          const SizedBox(height: 10),

                          // Subtitle with your original entrance animation
                          const AnimatedSubtitle()
                              .animate()
                              .fadeIn(
                                delay: const Duration(milliseconds: 1200),
                                curve: Curves.easeOutCubic,
                              )
                              .slideY(begin: -0.2),

                          const SizedBox(height: 40),

                          // Scroll indicator with bounce animation
                          GestureDetector(
                            onTap: _scrollToNextSection,
                            child: AnimatedBuilder(
                              animation: _bounceAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _bounceAnimation.value),
                                  child: Icon(
                                    LucideIcons.chevronsDown,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                );
                              },
                            )
                                .animate()
                                .fadeIn(
                                  delay: const Duration(milliseconds: 1400),
                                  curve: Curves.easeOutCubic,
                                ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  // Gradient overlay for transition
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Theme.of(context).scaffoldBackgroundColor,
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Next section content (placeholder)
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height,
              ),
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: const Center(
                child: Text(
                  'Next Section Content',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
