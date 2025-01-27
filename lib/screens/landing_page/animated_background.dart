// animated_background.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> controllers;
  late List<Animation<double>> fadeAnimations;
  late List<Animation<double>> scaleAnimations;
  final int totalSvgs = 15;
  late AnimationController loopController;
  late Animation<double> loopAnimation;

  @override
  void initState() {
    super.initState();

    // Initial entrance animations
    controllers = List.generate(
      totalSvgs,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 1300),
        vsync: this,
      ),
    );

    // Custom curve for more dramatic entrance
    const entranceCurve = Curves.easeInOutBack;

    fadeAnimations = controllers.map((controller) {
      return CurvedAnimation(
        parent: controller,
        curve: entranceCurve,
      );
    }).toList();

    scaleAnimations = controllers.map((controller) {
      return Tween<double>(begin: 0.98, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: entranceCurve,
        ),
      );
    }).toList();

    // Setup loop animation controller
    loopController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    loopAnimation = CurvedAnimation(
      parent: loopController,
      curve: Curves.easeInOutSine,
    );

    // Start the entrance sequence
    _startEntranceAnimations().then((_) => _startLoopingAnimation());
  }

  Future<void> _startEntranceAnimations() async {
    for (var i = 0; i < controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      controllers[i].forward();
    }
  }

  void _startLoopingAnimation() {
    loopController.repeat(reverse: true);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    loopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Initial SVGs (1-11)
          ...List.generate(11, (index) {
            return FadeTransition(
              opacity: fadeAnimations[index],
              child: ScaleTransition(
                scale: scaleAnimations[index],
                child: SvgPicture.asset(
                  'cccircular-${index + 1}.svg',
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),

          // Looping SVGs (11-15)
          ...List.generate(5, (index) {
            final svgIndex = index + 11;
            return AnimatedBuilder(
              animation: loopAnimation,
              builder: (context, child) {
                double opacity = 0.0;

                // Enhanced opacity calculation for smoother transitions
                if (index == 0) {
                  opacity = 1.0 - loopAnimation.value;
                } else if (index == 1) {
                  opacity = loopAnimation.value < 0.5
                      ? loopAnimation.value * 2
                      : (1.0 - loopAnimation.value) * 2;
                } else if (index == 2) {
                  opacity = loopAnimation.value > 0.5
                      ? (loopAnimation.value - 0.5) * 2
                      : 0.0;
                }

                return FadeTransition(
                  opacity: fadeAnimations[11],
                  child: Opacity(
                    opacity: opacity,
                    child: Transform.scale(
                      scale: 1.0 + (loopAnimation.value * 0.04),
                      child: SvgPicture.asset(
                        'cccircular-$svgIndex.svg',
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}