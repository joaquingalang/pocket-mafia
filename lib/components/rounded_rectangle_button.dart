import 'package:flutter/material.dart';
import 'package:pocket_mafia/theme.dart';

class RoundedRectangleButton extends StatefulWidget {
  const RoundedRectangleButton({
    super.key,
    required this.label,
    this.iconData,
    required this.onPressed,
    this.isDisabled = false,
  });

  final String label;
  final IconData? iconData;
  final VoidCallback onPressed;
  final bool isDisabled;

  @override
  State<RoundedRectangleButton> createState() => _RoundedRectangleButtonState();
}

class _RoundedRectangleButtonState extends State<RoundedRectangleButton> {

  bool _isPressed = false;

  Future<void> _handlePress(bool pressed) async {
    if (widget.isDisabled) return;
    setState(() {
      _isPressed = pressed;
    });

    if (!pressed) {
      await Future.delayed(const Duration(milliseconds: 50));
      widget.onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedOpacity(
      opacity: widget.isDisabled ? 0.25 : 1,
      duration: const Duration(milliseconds: 200),
      child: AnimatedOpacity(
        opacity: _isPressed ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: GestureDetector(
          onTapDown: (details) => _handlePress(true),
          onTapUp: (details) => _handlePress(false),
          child: Container(
            width: double.infinity,
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                if (!_isPressed) BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 10,
                  color: theme.colorScheme.onSecondary.withOpacity(0.5),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 5,
              children: [
                Text(
                  widget.label,
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: TextColors.buttonText,
                  ),
                ),
                if (widget.iconData != null) Icon(
                  widget.iconData,
                  color: theme.colorScheme.primary,
                  size: 24,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}