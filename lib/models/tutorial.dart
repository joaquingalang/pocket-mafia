final List<TutorialSlide> tutorialContent = [
  TutorialSlide(
      title: 'Set Up the Game',
      desc: 'Set the day, night, and voting durations, add players, and configure the game before it starts.',
  ),
  TutorialSlide(
      title: 'Manage Roles',
      desc: 'Assign Mafia and special roles like Headhunter or Mortician to add strategy and complexity.',
  ),
  TutorialSlide(
      title: 'Reveal Your Role',
      desc: 'At the start of the game, secretly view your assigned role and keep it hidden.',
  ),
  TutorialSlide(
      title: 'Discuss and Vote',
      desc: 'During the day, discuss who you think the Mafia are and vote to execute one player.',
  ),
  TutorialSlide(
      title: 'Night Actions',
      desc: 'At night, the Mafia choose a player to kill while special roles perform their abilities.',
  ),
  TutorialSlide(
      title: 'Win Conditions',
      desc: 'The village wins by eliminating all Mafia, while the Mafia wins when their numbers equal the villagers.',
  ),
];

class TutorialSlide {
  const TutorialSlide({
    required this.title,
    required this.desc,
    this.imagePath = 'assets/images/placeholder.png',
  });

  final String title;
  final String desc;
  final String imagePath;
}
