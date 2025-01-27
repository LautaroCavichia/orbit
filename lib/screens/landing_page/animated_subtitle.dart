import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedSubtitle extends StatefulWidget {
  const AnimatedSubtitle({super.key});

  @override
  State<AnimatedSubtitle> createState() => _AnimatedSubtitleState();
}

class _AnimatedSubtitleState extends State<AnimatedSubtitle>
    with SingleTickerProviderStateMixin {
  final List<String> verbWords = [
    'surrounded',
    'amazed',
    'inspired',
    'moved',
    'driven',
  ];

  final List<String> nounWords = [
    'people',
    'ideas',
    'projects',
    'innovations',
    'possibilities',
  ];

  int _verbIndex = 0;
  int _nounIndex = 0;
  String _currentVerb = '';
  String _currentNoun = '';
  bool _showVerbCursor = false;
  bool _showNounCursor = false;

  late AnimationController _gradientController;

  @override
  void initState() {
    super.initState();
    _currentVerb = verbWords[0];
    _currentNoun = nounWords[0];
    _startVerbAnimation();
    Future.delayed(const Duration(milliseconds: 1200), _startNounAnimation);

    _gradientController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);
  }

  Future<void> _typeWithCursor(String text, bool isVerb) async {
    setState(() {
      _showVerbCursor = isVerb;
      _showNounCursor = !isVerb;
    });

    String currentText = isVerb ? _currentVerb : _currentNoun;
    for (int i = currentText.length; i <= text.length; i++) {
      if (!mounted) return;
      setState(() {
        if (isVerb) {
          _currentVerb = text.substring(0, i);
        } else {
          _currentNoun = text.substring(0, i);
        }
      });
      await Future.delayed(Duration(milliseconds: 50 + (Random().nextInt(120))));
    }

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      if (isVerb) {
        _showVerbCursor = false;
      } else {
        _showNounCursor = false;
      }
    });
  }

  void _startVerbAnimation() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 7000));
      setState(() => _currentVerb = '');
      await Future.delayed(const Duration(milliseconds: 300));

      _verbIndex = (_verbIndex + 1) % verbWords.length;
      await _typeWithCursor(verbWords[_verbIndex], true);
    }
  }

  void _startNounAnimation() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 7000));
      setState(() => _currentNoun = '');
      await Future.delayed(const Duration(milliseconds: 300));

      _nounIndex = (_nounIndex + 1) % nounWords.length;
      await _typeWithCursor(nounWords[_nounIndex], false);
    }
  }

  Widget _buildTypingText(String text, bool isVerb) {
    return AnimatedBuilder(
      animation: _gradientController,
      builder: (context, child) {
        final gradient = LinearGradient(
          colors: [
            const Color.fromARGB(255, 219, 240, 238),
            const Color.fromARGB(255, 229, 153, 209),
          ],
          stops: [
            0.5 + 0.5 * sin(_gradientController.value * 2 * pi),
            1.0,
          ],
        );

        return ShaderMask(
          shaderCallback: (bounds) => gradient.createShader(bounds),
          child: child,
        );
      },
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: text),
            if ((isVerb && _showVerbCursor) || (!isVerb && _showNounCursor))
              const TextSpan(
                text: '|',
                style: TextStyle(fontWeight: FontWeight.w200),
                
              ),
          ],
        ),
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Get ',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
        ),
        _buildTypingText(_currentVerb, true),
        Text(
          ' by ',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
        ),
        _buildTypingText(_currentNoun, false),
      ],
    ).animate()
        .fadeIn(delay: const Duration(milliseconds: 1400))
        .slideY(begin: -0.2);
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }
}
