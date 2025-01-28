import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'dart:ui';
import 'package:lucide_icons/lucide_icons.dart';

class OverviewSection extends StatefulWidget {
  const OverviewSection({Key? key}) : super(key: key);

  @override
  _OverviewSectionState createState() => _OverviewSectionState();
}

class _OverviewSectionState extends State<OverviewSection> {
  Widget _buildFeatureTile({
    required String title,
    required IconData icon,
    required String description,
  }) {
    return MouseRegion(
      child: Builder(
        builder: (context) {
          bool isHovered = false;

          return StatefulBuilder(
            builder: (context, setInnerState) {
              return MouseRegion(
                onEnter: (_) => setInnerState(() => isHovered = true),
                onExit: (_) => setInnerState(() => isHovered = false),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              icon,
                              size: 32,
                              color: isHovered 
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.white.withOpacity(0.9),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ).animate(target: isHovered ? 1 : 0)
                        .scale(begin: Offset(1, 1), end: Offset(1.05, 1.05))
                        .boxShadow(
                          begin: BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: -5,
                          ),
                          end: BoxShadow(
                            color: Theme.of(context).primaryColor.withOpacity(1),
                            blurRadius: 20,
                            spreadRadius: 20,
                          ),
                        ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
      Stack(
        children: [
          SvgPicture.asset('cccircular-16.svg',
          fit: BoxFit.cover,
          ),

      //add gradient from top to bottom
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.transparent,
              Colors.black38,
              Colors.black,
            ],
          ),
        ),
      ),
      const SizedBox(height: 100),
      Center(
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1.3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            _buildFeatureTile(
              title: 'Explore Projects',
              icon: LucideIcons.compass,
              description: 'Discover and join exciting group projects',
            ).animate()
              .fadeIn(delay: 300.ms, duration: 600.ms)
              .slideY(begin: 0.2, delay: 300.ms, duration: 600.ms),
            _buildFeatureTile(
              title: 'Share Ideas',
              icon: LucideIcons.lightbulb,
              description: 'Share your innovative ideas with the community',
            ).animate()
              .fadeIn(delay: 400.ms, duration: 600.ms)
              .slideY(begin: 0.2, delay: 400.ms, duration: 600.ms),
            _buildFeatureTile(
              title: 'Find Peers',
              icon: LucideIcons.users,
              description: 'Connect with like-minded developers',
            ).animate()
              .fadeIn(delay: 500.ms, duration: 600.ms)
              .slideY(begin: 0.2, delay: 500.ms, duration: 600.ms),
            _buildFeatureTile(
              title: 'Discuss Topics',
              icon: LucideIcons.messageSquare,
              description: 'Engage in meaningful technical discussions',
            ).animate()
              .fadeIn(delay: 600.ms, duration: 600.ms)
              .slideY(begin: 0.2, delay: 600.ms, duration: 600.ms),
            _buildFeatureTile(
              title: 'Link GitHub',
              icon: LucideIcons.github,
              description: 'Showcase your open source contributions',
            ).animate()
              .fadeIn(delay: 700.ms, duration: 600.ms)
              .slideY(begin: 0.2, delay: 700.ms, duration: 600.ms),
            _buildFeatureTile(
              title: 'Link LinkedIn',
              icon: LucideIcons.linkedin,
              description: 'Connect your professional profile',
            ).animate()
              .fadeIn(delay: 800.ms, duration: 600.ms)
              .slideY(begin: 0.2, delay: 800.ms, duration: 600.ms),
          ],
        ),
      ),
            ],
      );
  }
}