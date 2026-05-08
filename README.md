
<p align="center">
 <img width="100px" src="https://github.com/user-attachments/assets/c76cc294-d767-4115-8f38-0d5b23c4c11a" align="center" alt="Pocket Mafia" />
 <h2 align="center">Pocket Mafia</h2>
 <p align="center">Moderator for the Classic Mafia Party Game</p>
</p>

<p align="center">
    <a href="https://github.com/joaquingalang/pocket-mafia/graphs/contributors">
      <img alt="GitHub Contributors" src="https://img.shields.io/github/contributors/joaquingalang/pocket-mafia?color=0088ff"/>
    </a>
    <a href="https://github.com/joaquingalang/pocket-mafia/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/joaquingalang/pocket-mafia?color=0088ff"/>
    </a>
    <a href="https://github.com/joaquingalang/pocket-mafia/pulls">
      <img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/joaquingalang/pocket-mafia?color=0088ff"/>
    </a>
</p>

<p align="center">
    <a href="/">View Demo</a>
    ·
    <a href="https://github.com/joaquingalang/pocket-mafia/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml">Report Bug</a>
    ·
    <a href="https://github.com/joaquingalang/pocket-mafia/issues/new?assignees=&labels=enhancement&projects=&template=feature_request.yml">Request Feature</a>
    ·
    <a href="https://github.com/joaquingalang/pocket-mafia/discussions/1770">FAQ</a>
    ·
    <a href="https://github.com/joaquingalang/pocket-mafia/discussions/new?category=q-a">Ask Question</a>
</p>

## About the Project

Pocket Mafia is an automated moderator for the classic Mafia party game. Play face-to-face with your friends while the app handles everything a human moderator would — assigning roles, running phase timers for day discussion and night actions, tallying elimination votes, and prompting special roles to take their nightly actions. No dedicated moderator needed; everyone gets to play.

## Features

- **Role Selection** — Choose from 14+ roles to include in the game. Roles are randomly assigned to players when the game starts.
- **Moderated Gameplay** — Pocket Mafia automatically moderates each round: tracks discussion time, tallies votes, and prompts night actions from special roles.
- **Configurable Timers** — Set custom durations for the day discussion phase, voting phase, and night phase before each game.
- **Text-to-Speech Narration** — Automated voice announcements guide players through each phase, keeping the game flowing without anyone reading from a screen.
- **Game Summary** — Review round-by-round stats and outcomes at the end of each game.
- **Built-in Tutorial & FAQ** — New players can learn the rules and get answers to common questions directly inside the app.
- **Dark-themed UI** — A polished, mobile-first interface designed for low-light game nights.

## Available Roles

| Team | Roles |
|------|-------|
| **Mafia** | Mafia, Saboteur |
| **Village** | Villager, Detective, Doctor, Vigilante, Mortician, Snitch, Celebrity, Preacher, Medium |
| **Neutral** | Jester, Headhunter, Lover |

## Tech Stack

- **Flutter / Dart** — Cross-platform mobile framework (SDK `^3.10.0`)
- **flutter_tts** — Text-to-speech narration
- **audioplayers** — Sound effects
- **shared_preferences** — Local data persistence
- **google_fonts** — Typography
- **sizer** — Responsive layout scaling
- **particles_flutter** — Particle animation effects
- **percent_indicator** — Timer progress indicators
- **flutter_svg** — SVG asset rendering

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `^3.10.0`
- Dart (bundled with Flutter)
- Android Studio (for Android) or Xcode (for iOS)

## Getting Started

```bash
git clone https://github.com/joaquingalang/pocket-mafia.git
cd pocket-mafia
flutter pub get
flutter run
```

To target a specific platform:

```bash
flutter run -d android   # Android device or emulator
flutter run -d ios       # iOS device or simulator (macOS only)
```

## Project Structure

```
lib/
├── main.dart               # App entry point
├── theme.dart              # Global color scheme and typography
├── pages/                  # 15 screen pages (home, setup, gameplay, results, etc.)
├── components/             # 8 reusable widgets (buttons, tiles, timer, app bars)
├── models/                 # Data classes: Game, Player, Role, Tutorial
├── enums/                  # Roles, Phase, VoteResult, TeamVictory
└── utils/                  # String helper utilities
```

## Contributing

Bug reports and feature requests are welcome. Use the [bug report](https://github.com/joaquingalang/pocket-mafia/issues/new?assignees=&labels=bug&projects=&template=bug_report.yml) and [feature request](https://github.com/joaquingalang/pocket-mafia/issues/new?assignees=&labels=enhancement&projects=&template=feature_request.yml) templates on GitHub Issues. Pull requests are also appreciated.
