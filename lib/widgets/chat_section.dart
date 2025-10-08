import 'package:flutter/material.dart';
import 'package:voice_assistent/color_palete.dart';
import 'package:voice_assistent/config/app_constants.dart';
import 'package:voice_assistent/models/chat_message.dart';

/// Chat section widget containing message list and typing indicator
class ChatSection extends StatelessWidget {
  final List<ChatMessage> messages;
  final bool isTyping;
  final bool isDarkMode;
  final ScrollController scrollController;
  final Animation<double> typingAnimation;
  final Function(String) onMessageSpeak;

  const ChatSection({
    super.key,
    required this.messages,
    required this.isTyping,
    required this.isDarkMode,
    required this.scrollController,
    required this.typingAnimation,
    required this.onMessageSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            padding: AppConstants.defaultPadding,
            itemCount: messages.length + (isTyping ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == messages.length && isTyping) {
                return _TypingIndicator(
                  animation: typingAnimation,
                  isDarkMode: isDarkMode,
                );
              }
              final message = messages[index];
              return ChatMessageBubble(
                message: message,
                isDarkMode: isDarkMode,
                onSpeak: () => onMessageSpeak(message.text),
              );
            },
          ),
        ),
        _QuickReplyButtons(isDarkMode: isDarkMode),
      ],
    );
  }
}

/// Individual chat message bubble
class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isDarkMode;
  final VoidCallback onSpeak;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isDarkMode,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isUser) _UserAvatar(isUser: false, isDarkMode: isDarkMode),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: AppConstants.messagePadding,
                  decoration: BoxDecoration(
                    gradient: message.isUser
                        ? LinearGradient(
                            colors: [
                              ColorPalette.mainFontColor,
                              ColorPalette.mainFontColor.withOpacity(0.8),
                            ],
                          )
                        : LinearGradient(
                            colors: isDarkMode
                                ? [const Color(0xFF3A3A3A), const Color(0xFF4A4A4A)]
                                : [ColorPalette.firstSuggestionBoxColor, ColorPalette.firstSuggestionBoxColor.withOpacity(0.7)],
                          ),
                    borderRadius: BorderRadius.circular(AppConstants.messageCornerRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.type == MessageType.image && message.imageUrl != null && message.imageUrl!.isNotEmpty)
                        _buildImageContent(),
                      Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUser
                              ? ColorPalette.whiteColor
                              : (isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor),
                          fontSize: AppConstants.messageTextSize,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
                  children: [
                    if (!message.isUser)
                      IconButton(
                        onPressed: onSpeak,
                        icon: Icon(
                          Icons.volume_up,
                          size: 16,
                          color: (isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor).withOpacity(0.7),
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    Text(
                      '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: AppConstants.timestampTextSize,
                        color: (isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor).withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (message.isUser) _UserAvatar(isUser: true, isDarkMode: isDarkMode),
        ],
      ),
    );
  }

  Widget _buildImageContent() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            message.imageUrl!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.error, color: Colors.red, size: 40),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// User/AI avatar widget
class _UserAvatar extends StatelessWidget {
  final bool isUser;
  final bool isDarkMode;

  const _UserAvatar({
    required this.isUser,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isUser 
            ? ColorPalette.mainFontColor 
            : (isDarkMode ? const Color(0xFF3A3A3A) : ColorPalette.assistentCircleColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy,
        color: isUser 
            ? ColorPalette.whiteColor 
            : (isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor),
        size: 20,
      ),
    );
  }
}

/// Typing indicator widget
class _TypingIndicator extends StatelessWidget {
  final Animation<double> animation;
  final bool isDarkMode;

  const _TypingIndicator({
    required this.animation,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          _UserAvatar(isUser: false, isDarkMode: isDarkMode),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF3A3A3A) : ColorPalette.firstSuggestionBoxColor,
              borderRadius: BorderRadius.circular(AppConstants.messageCornerRadius),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TypingDot(animation: animation, index: 0, isDarkMode: isDarkMode),
                const SizedBox(width: 4),
                _TypingDot(animation: animation, index: 1, isDarkMode: isDarkMode),
                const SizedBox(width: 4),
                _TypingDot(animation: animation, index: 2, isDarkMode: isDarkMode),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual typing animation dot
class _TypingDot extends StatelessWidget {
  final Animation<double> animation;
  final int index;
  final bool isDarkMode;

  const _TypingDot({
    required this.animation,
    required this.index,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        double offset = (index * 0.2) % 1.0;
        double animValue = (animation.value + offset) % 1.0;
        return Transform.translate(
          offset: Offset(0, -10 * (1 - (2 * animValue - 1).abs())),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}

/// Quick reply buttons widget
class _QuickReplyButtons extends StatelessWidget {
  final bool isDarkMode;

  const _QuickReplyButtons({
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.defaultQuickReplies.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: Material(
              color: isDarkMode 
                  ? const Color(0xFF3A3A3A) 
                  : ColorPalette.secondSuggestionBoxColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {
                  // TODO: Implement quick reply functionality
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    AppConstants.defaultQuickReplies[index],
                    style: TextStyle(
                      color: isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}