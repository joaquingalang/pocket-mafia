import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:pocket_mafia/pages/home_page.dart';
import 'theme.dart';

void main() {
  runApp(PocketMafia());
}

class PocketMafia extends StatelessWidget {
  const PocketMafia({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          home: HomePage(),
          theme: darkTheme,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
