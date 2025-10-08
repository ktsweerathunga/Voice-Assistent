import 'package:flutter/material.dart';

/// Model class for quick action items
class QuickAction {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String message;
  final List<Color> gradient;

  QuickAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.message,
    required this.gradient,
  });

  /// Convert to Map for storage/serialization
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'icon': icon.codePoint,
      'message': message,
      // Note: Colors and gradients would need special handling for serialization
    };
  }
}

/// Response model for AI service responses
class AIResponse {
  final bool success;
  final String content;
  final String? imageUrl;
  final String type;

  AIResponse({
    required this.success,
    required this.content,
    this.imageUrl,
    required this.type,
  });

  /// Create from Map (from AI service response)
  factory AIResponse.fromMap(Map<String, dynamic> map) {
    return AIResponse(
      success: map['success'] ?? false,
      content: map['content'] ?? '',
      imageUrl: map['imageUrl'],
      type: map['type'] ?? 'text',
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'content': content,
      'imageUrl': imageUrl,
      'type': type,
    };
  }
}