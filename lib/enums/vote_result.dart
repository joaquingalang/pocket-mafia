import 'dart:math';

import 'package:pocket_mafia/models/player.dart';

enum VoteResult {
  executed,
  divided,
  spared;

  String getIconPath() {
    switch (this) {
      case VoteResult.executed:
        return 'assets/images/icons/dead_icon.svg';
      case VoteResult.spared:
        return 'assets/images/icons/peace_icon.svg';
      case VoteResult.divided:
        return 'assets/images/icons/scales_icon.svg';
    }
  }

  String getTitle(Player player) {
    switch (this) {
      case VoteResult.executed:
        return player.name.toUpperCase();
      case VoteResult.spared:
        return 'Everyone Is Spared';
      case VoteResult.divided:
        return 'Village Is Divided';
    }
  }

  String getSubtitle(Player player) {
    if (this == VoteResult.executed) {
      return player.role.name!.toUpperCase();
    }
    return 'NO BLOOD SPILLED';
  }

  String getPhrase(Player player) {
    final random = Random();
    final name = player.name;
    switch (this) {
      case VoteResult.executed:
        final executedPhrases = [
          "The verdict stands. $name meets their end.",
          "Judgment falls. $name is no more.",
          "The village decides. $name is finished.",
          "Fate is sealed. $name faces the end.",
          "The crowd has spoken. $name is condemned.",
          "The sentence is carried out. $name falls.",
          "No mercy remains. $name is executed.",
          "The end is swift. $name is gone.",
          "The decision is final. $name perishes.",
          "Justice is served. $name meets their fate.",
          "The village delivers judgment. $name falls today.",
          "The choice is clear. $name is doomed.",
          "The sentence stands. $name will not survive.",
          "All is decided. $name meets the gallows.",
          "The crowd demands it. $name is put down.",
        ];
        return executedPhrases[random.nextInt(executedPhrases.length)];
      case VoteResult.divided:
        final sparedPhrases = [
          "Mercy prevails. No blood is shed today.",
          "The village relents. No one is punished.",
          "Compassion wins. All remain unharmed.",
          "No judgment falls. The village shows restraint.",
          "The people hesitate. No life is taken.",
          "Mercy is granted. The day passes gently.",
          "The village forgives. No one falls today.",
          "No sentence is given. All are spared.",
          "The crowd softens. No one is condemned.",
          "The village holds back. Peace remains.",
          "No blade falls. The village chooses mercy.",
          "Judgment is withheld. No one pays the price.",
          "The people show grace. All survive today.",
          "The village pauses. No fate is sealed.",
          "Mercy stands. No one meets the end.",
        ];
        return sparedPhrases[random.nextInt(sparedPhrases.length)];
      case VoteResult.spared:
        final dividedPhrases = [
          "The vote splits. No fate is decided.",
          "No consensus forms. The day slips by.",
          "The village is torn. Nothing is done.",
          "Voices clash. No judgment is reached.",
          "The tally fails. No action follows.",
          "Division reigns. The day ends quietly.",
          "No majority rises. Nothing changes.",
          "The village wavers. No decision stands.",
          "Opinions scatter. No one is chosen.",
          "The count is even. No fate is sealed.",
          "The crowd divides. No verdict emerges.",
          "No unity forms. The moment passes.",
          "The vote falters. No consequence follows.",
          "The village cannot agree. The day moves on.",
          "The decision stalls. Nothing comes of it.",
        ];
        return dividedPhrases[random.nextInt(dividedPhrases.length)];
    }
  }
}