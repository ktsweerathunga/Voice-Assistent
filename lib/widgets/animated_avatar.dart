import 'package:flutter/material.dart';
import 'package:voice_assistent/color_palete.dart';
import 'package:voice_assistent/config/app_constants.dart';

/// Animated avatar widget for the AI assistant
class AnimatedAvatar extends StatelessWidget {
  final Animation<double> pulseAnimation;
  final Animation<double> scaleAnimation;
  final Animation<double> waveAnimation;
  final bool isListening;
  final bool isDarkMode;

  const AnimatedAvatar({
    super.key,
    required this.pulseAnimation,
    required this.scaleAnimation,
    required this.waveAnimation,
    required this.isListening,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDarkMode
              ? [
                  const Color(0xFF2A2A2A),
                  const Color(0xFF1A1A1A),
                ]
              : [
                  ColorPalette.firstSuggestionBoxColor.withOpacity(0.3),
                  ColorPalette.whiteColor,
                ],
        ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: pulseAnimation.value,
              child: AnimatedBuilder(
                animation: scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: scaleAnimation.value,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer glow effect
                        Container(
                          height: AppConstants.avatarGlowSize,
                          width: AppConstants.avatarGlowSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: (isListening 
                                    ? ColorPalette.thirdSuggestionBoxColor 
                                    : ColorPalette.assistentCircleColor).withOpacity(0.4),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        // Main avatar
                        Container(
                          height: AppConstants.avatarSize,
                          width: AppConstants.avatarSize,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isListening
                                  ? [
                                      ColorPalette.thirdSuggestionBoxColor,
                                      ColorPalette.secondSuggestionBoxColor,
                                    ]
                                  : [
                                      ColorPalette.assistentCircleColor,
                                      ColorPalette.firstSuggestionBoxColor,
                                    ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isListening ? Icons.mic : Icons.smart_toy,
                            size: 50,
                            color: ColorPalette.mainFontColor,
                          ),
                        ),
                        // Wave animation when listening
                        if (isListening) _buildListeningWaveAnimation(),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListeningWaveAnimation() {
    return AnimatedBuilder(
      animation: waveAnimation,
      builder: (context, child) {
        return Container(
          height: AppConstants.waveAnimationSize,
          width: AppConstants.waveAnimationSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorPalette.thirdSuggestionBoxColor.withOpacity(
                (1 - waveAnimation.value) * 0.5,
              ),
              width: 2,
            ),
          ),
        );
      },
    );
  }
}