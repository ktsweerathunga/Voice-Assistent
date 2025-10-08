import 'package:flutter/material.dart';
import 'package:voice_assistent/color_palete.dart';
import 'package:voice_assistent/config/app_constants.dart';
import 'package:voice_assistent/models/quick_action.dart';

/// Grid widget for displaying quick action cards
class QuickActionGrid extends StatelessWidget {
  final List<QuickAction> actions;
  final bool isDarkMode;
  final Function(QuickAction) onActionTapped;

  const QuickActionGrid({
    super.key,
    required this.actions,
    required this.isDarkMode,
    required this.onActionTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: AppConstants.defaultPadding,
          child: Text(
            AppConstants.welcomeMessage,
            style: TextStyle(
              fontSize: AppConstants.sectionTitleSize,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppConstants.quickActionGridColumns,
              crossAxisSpacing: AppConstants.quickActionGridSpacing,
              mainAxisSpacing: AppConstants.quickActionGridSpacing,
              childAspectRatio: AppConstants.quickActionCardAspectRatio,
            ),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              return _QuickActionCard(
                action: actions[index],
                isDarkMode: isDarkMode,
                onTap: () => onActionTapped(actions[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Individual quick action card widget
class _QuickActionCard extends StatelessWidget {
  final QuickAction action;
  final bool isDarkMode;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.action,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [const Color(0xFF3A3A3A), const Color(0xFF2A2A2A)]
              : action.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.actionCardCornerRadius),
        boxShadow: [
          BoxShadow(
            color: action.color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.actionCardCornerRadius),
          onTap: onTap,
          child: Container(
            padding: AppConstants.cardPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorPalette.whiteColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    action.icon,
                    color: ColorPalette.mainFontColor,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  action.title,
                  style: TextStyle(
                    fontSize: AppConstants.actionTitleSize,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  action.subtitle,
                  style: TextStyle(
                    fontSize: AppConstants.actionSubtitleSize,
                    color: (isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor).withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}