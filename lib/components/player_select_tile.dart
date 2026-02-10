import 'package:flutter/material.dart';
import 'package:pocket_mafia/theme.dart';

class PlayerSelectTile extends StatelessWidget {
  const PlayerSelectTile({
    super.key,
    required this.name,
    required this.id,
    required this.value,
    required this.onChanged,
  });

  final String name;
  final int id;
  final bool value;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Avatar Box
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSecondary.withOpacity(0.25),
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          // Offset
          SizedBox(width: 20),

          // Name Label
          Text(
            name,
            style: theme.textTheme.titleMedium,
            overflow: TextOverflow.ellipsis,
          ),

          Spacer(),

          // Remove Button
          Checkbox(
            value: value,
            onChanged: onChanged,
            shape: CircleBorder(),
          ),

          // Offset
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
