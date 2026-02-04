import 'package:flutter/material.dart';
import 'package:pocket_mafia/theme.dart';

class PillButton extends StatefulWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {

  bool _isPressed = false;

  Future<void> _handlePress(bool pressed) async {
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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AnimatedOpacity(
        opacity: _isPressed ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: GestureDetector(
          onTapDown: (details) => _handlePress(true),
          onTapUp: (details) => _handlePress(false),
          child: Container(
            width: 200,
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(1000),
              boxShadow: [
                if (!_isPressed) BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 10,
                  color: theme.colorScheme.onSecondary.withOpacity(0.5),
                )
              ],
            ),
            child: Center(
              child: Text(
                widget.label,
                style: theme.textTheme.labelLarge!.copyWith(
                  color: TextColors.buttonText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}