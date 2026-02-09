import 'package:flutter/material.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({super.key, required this.name, required this.id});

  final String name;
  final int id;

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
          Text(name, style: theme.textTheme.labelLarge),
          Text(
            '#$id',
            style: theme.textTheme.labelLarge!.copyWith(
              color: const Color(0xFF4E5F79),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}