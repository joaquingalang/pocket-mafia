import 'package:flutter/material.dart';

class GameAppBar extends StatelessWidget {
  const GameAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onClose,
    required this.onInfo,
  });

  final String title;
  final String subtitle;
  final VoidCallback onClose;
  final VoidCallback onInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),


          Column(
            children: [
              Text(title, style: theme.textTheme.headlineSmall),
              Text(subtitle, style: theme.textTheme.labelSmall),
            ],
          ),

          // Offset
          GestureDetector(
            onTap: onInfo,
            child: Icon(
              Icons.info,
              color: theme.colorScheme.onSecondary,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}