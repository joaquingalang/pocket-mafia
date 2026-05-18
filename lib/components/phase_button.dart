import 'package:flutter/material.dart';

class PhaseButton extends StatefulWidget {
  const PhaseButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.trailing,
    this.isPrimary = true,
  });

  final String label;
  final VoidCallback onPressed;
  final Widget? trailing;
  final bool isPrimary;

  @override
  State<PhaseButton> createState() => _PhaseButtonState();
}

class _PhaseButtonState extends State<PhaseButton> {
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
    return Expanded(
      child: AnimatedOpacity(
        opacity: _isPressed ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: GestureDetector(
          onTapDown: (details) => _handlePress(true),
          onTapUp: (details) => _handlePress(false),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: widget.isPrimary
                  ? theme.colorScheme.onSecondary
                  : theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: [
                Text(
                  widget.label,
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: widget.isPrimary ? theme.colorScheme.primary : null,
                  ),
                ),

                widget.trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}