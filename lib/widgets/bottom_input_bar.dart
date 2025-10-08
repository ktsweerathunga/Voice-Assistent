import 'package:flutter/material.dart';
import 'package:voice_assistent/color_palete.dart';
import 'package:voice_assistent/config/app_constants.dart';
import 'package:voice_assistent/widgets/round_icon_button.dart';

/// Bottom input bar widget with text field and buttons
class BottomInputBar extends StatelessWidget {
  final TextEditingController textController;
  final bool isDarkMode;
  final bool isListening;
  final VoidCallback onSendMessage;
  final VoidCallback onToggleListening;

  const BottomInputBar({
    super.key,
    required this.textController,
    required this.isDarkMode,
    required this.isListening,
    required this.onSendMessage,
    required this.onToggleListening,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConstants.defaultPadding,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2A2A2A) : ColorPalette.whiteColor,
        border: Border(
          top: BorderSide(
            color: (isDarkMode ? ColorPalette.whiteColor : ColorPalette.borderColor).withOpacity(0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode 
                    ? const Color(0xFF3A3A3A) 
                    : ColorPalette.firstSuggestionBoxColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: (isDarkMode ? ColorPalette.whiteColor : ColorPalette.borderColor).withOpacity(0.3),
                ),
              ),
              child: TextField(
                controller: textController,
                style: TextStyle(
                  color: isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
                ),
                decoration: InputDecoration(
                  hintText: AppConstants.typeMessageHint,
                  hintStyle: TextStyle(
                    color: (isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor).withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (value) => onSendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          RoundIconButton(
            onTap: onToggleListening,
            gradient: isListening
                ? [ColorPalette.thirdSuggestionBoxColor, ColorPalette.secondSuggestionBoxColor]
                : [ColorPalette.mainFontColor, ColorPalette.mainFontColor.withOpacity(0.8)],
            icon: isListening ? Icons.mic : Icons.mic_none,
          ),
          const SizedBox(width: 8),
          RoundIconButton(
            onTap: onSendMessage,
            gradient: [ColorPalette.mainFontColor, ColorPalette.mainFontColor.withOpacity(0.8)],
            icon: Icons.send,
          ),
        ],
      ),
    );
  }
}