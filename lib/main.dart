import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_mafia/blocs/game_bloc.dart';
import 'package:pocket_mafia/observer/game_bloc_observer.dart';
import 'package:pocket_mafia/pages/add_players_page.dart';
import 'package:pocket_mafia/pages/game_setup_page.dart';
import 'package:pocket_mafia/pages/game_summary_page.dart';
import 'package:pocket_mafia/pages/role_reveal_page.dart';
import 'package:pocket_mafia/pages/role_select_page.dart';
import 'package:pocket_mafia/pages/settings_page.dart';
import 'package:pocket_mafia/pages/tutorial_page.dart';
import 'package:pocket_mafia/views/voting_view.dart';
import 'package:pocket_mafia/views/vote_result_view.dart';
import 'package:sizer/sizer.dart';
import 'package:pocket_mafia/pages/home_page.dart';
import 'theme.dart';

void main() {
  Bloc.observer = GameBlocObserver();
  runApp(PocketMafia());
}

class PocketMafia extends StatelessWidget {
  const PocketMafia({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return BlocProvider(
          create: (_) => GameBloc(),
          child: MaterialApp(
            home: HomePage(),
            theme: darkTheme,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
