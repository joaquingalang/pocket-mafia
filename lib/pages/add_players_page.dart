import 'package:flutter/material.dart';
import 'package:pocket_mafia/components/main_app_bar.dart';
import 'package:pocket_mafia/components/rounded_rectangle_button.dart';
import 'package:pocket_mafia/theme.dart';

class AddPlayersPage extends StatefulWidget {
  const AddPlayersPage({super.key});

  @override
  State<AddPlayersPage> createState() => _AddPlayersPageState();
}

class _AddPlayersPageState extends State<AddPlayersPage> {
  final TextEditingController _nameController = TextEditingController();
  List<String> players = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 30),
          child: Column(
            children: [
              MainAppBar(label: 'Add Players'),

              // Offset
              SizedBox(height: 35),

              // Add Player Field
              AddPlayerTextField(
                nameController: _nameController,
                onAdd: (name) {
                  setState(() {
                    players.insert(0, name);
                  });
                },
              ),

              // Offset
              SizedBox(height: 20),

              // Players
              Expanded(
                child: ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    return PlayerListTile(
                      name: players[index],
                      onClose: () {
                        setState(() {
                          players.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),

              RoundedRectangleButton(
                label: 'PICK ROLES',
                iconData: Icons.arrow_forward,
                onPressed: () {},
              ),

              // Offset
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPlayerTextField extends StatefulWidget {
  const AddPlayerTextField({
    super.key,
    required TextEditingController nameController,
    required this.onAdd,
  }) : _nameController = nameController;

  final TextEditingController _nameController;
  final void Function(String) onAdd;

  @override
  State<AddPlayerTextField> createState() => _AddPlayerTextFieldState();
}

class _AddPlayerTextFieldState extends State<AddPlayerTextField> {
  bool _isPressed = false;

  Future<void> _handlePress(bool pressed) async {
    setState(() {
      _isPressed = pressed;
    });

    if (!pressed) {
      await Future.delayed(const Duration(milliseconds: 50));
      widget.onAdd(widget._nameController.text);
      widget._nameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: TextField(
            controller: widget._nameController,
            cursorColor: TextColors.primaryText,
            decoration: InputDecoration(
              hintText: 'Enter a name...',
              hintStyle: theme.textTheme.bodyMedium!.copyWith(
                color: TextColors.tertiaryText,
              ),
              fillColor: theme.colorScheme.secondary,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: theme.colorScheme.onSecondary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: _isPressed ? 0.5 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: GestureDetector(
            onTapDown: (details) => _handlePress(true),
            onTapUp: (details) => _handlePress(false),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.add,
                color: theme.colorScheme.primary,
                size: 36,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PlayerListTile extends StatelessWidget {
  const PlayerListTile({super.key, required this.name, required this.onClose});

  final String name;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
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
          GestureDetector(
            onTap: onClose,
            child: Icon(Icons.close, color: TextColors.primaryText),
          ),

          // Offset
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
