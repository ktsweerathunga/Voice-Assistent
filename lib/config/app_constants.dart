import 'package:flutter/material.dart';
import 'package:voice_assistent/color_palete.dart';
import 'package:voice_assistent/models/quick_action.dart';

/// Application constants and configurations
class AppConstants {
  // Animation durations
  static const Duration pulseAnimationDuration = Duration(seconds: 2);
  static const Duration listeningAnimationDuration = Duration(milliseconds: 300);
  static const Duration typingAnimationDuration = Duration(milliseconds: 1500);
  static const Duration scrollAnimationDuration = Duration(milliseconds: 300);

  // UI dimensions
  static const double avatarSize = 120.0;
  static const double avatarGlowSize = 140.0;
  static const double waveAnimationSize = 160.0;
  static const double quickActionCardAspectRatio = 1.2;
  static const double messageCornerRadius = 20.0;
  static const double actionCardCornerRadius = 20.0;

  // Text sizes
  static const double appBarTitleSize = 20.0;
  static const double sectionTitleSize = 24.0;
  static const double messageTextSize = 16.0;
  static const double timestampTextSize = 12.0;
  static const double actionTitleSize = 14.0;
  static const double actionSubtitleSize = 11.0;

  // Spacing
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets messagePadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);

  // Grid configuration
  static const int quickActionGridColumns = 2;
  static const double quickActionGridSpacing = 12.0;

  // TTS configuration
  static const String defaultTtsLanguage = "en-US";
  static const double defaultTtsSpeechRate = 0.5;
  static const double defaultTtsVolume = 1.0;
  static const double defaultTtsPitch = 1.0;

  // Quick replies
  static const List<String> defaultQuickReplies = [
    'Thanks!',
    'Tell me more',
    'That is helpful',
    'What else?'
  ];

  // App strings
  static const String appTitle = 'AI Assistant';
  static const String welcomeMessage = 'How can I help you today?';
  static const String typeMessageHint = 'Type your message...';
  static const String speechPermissionError = 
    'Speech recognition permission is required. Please enable microphone access in your device settings.';
}

/// Quick action configurations
class QuickActionData {
  static List<QuickAction> getDefaultActions() {
    return [
      QuickAction(
        title: 'Ask about Weather',
        subtitle: 'Get current weather info',
        icon: Icons.wb_sunny,
        color: ColorPalette.firstSuggestionBoxColor,
        message: 'What is the weather like today?',
        gradient: [ColorPalette.firstSuggestionBoxColor, const Color(0xFFB3E5FC)],
      ),
      QuickAction(
        title: 'Set Reminder',
        subtitle: 'Create a new reminder',
        icon: Icons.alarm,
        color: ColorPalette.secondSuggestionBoxColor,
        message: 'Set a reminder for tomorrow',
        gradient: [ColorPalette.secondSuggestionBoxColor, const Color(0xFF81C784)],
      ),
      QuickAction(
        title: 'Tell me a Joke',
        subtitle: 'Brighten your day',
        icon: Icons.sentiment_very_satisfied,
        color: ColorPalette.thirdSuggestionBoxColor,
        message: 'Tell me a funny joke',
        gradient: [ColorPalette.thirdSuggestionBoxColor, const Color(0xFFFFB74D)],
      ),
      QuickAction(
        title: 'Play Music',
        subtitle: 'Start your playlist',
        icon: Icons.music_note,
        color: const Color(0xFFE1BEE7),
        message: 'Play my favorite music',
        gradient: [const Color(0xFFE1BEE7), const Color(0xFFCE93D8)],
      ),
      QuickAction(
        title: 'Get News',
        subtitle: 'Latest headlines',
        icon: Icons.newspaper,
        color: const Color(0xFFFFCDD2),
        message: 'Show me today news',
        gradient: [const Color(0xFFFFCDD2), const Color(0xFFEF9A9A)],
      ),
      QuickAction(
        title: 'Help & Support',
        subtitle: 'Learn what I can do',
        icon: Icons.help_outline,
        color: const Color(0xFFDCEDC8),
        message: 'What can you help me with?',
        gradient: [const Color(0xFFDCEDC8), const Color(0xFFC8E6C9)],
      ),
    ];
  }
}