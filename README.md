# Gambit Game

A 2D action platformer game built with Flutter and the Flame engine.

## 🎮 About

Gambit Game is an action-packed platformer featuring a hero character with multiple abilities including running, jumping, and attacking. Fight against enemies in an immersive 2D world with smooth animations and responsive controls.

## ✨ Features

- **Smooth Character Animations**: Idle, run, jump, and attack states
- **Physics-Based Movement**: Realistic gravity and jump mechanics
- **Touch Controls**: Intuitive directional pad and action buttons
- **Collision Detection**: Advanced hitbox-based collision system
- **Responsive Design**: Works across multiple platforms (Android, iOS, Web, Desktop)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.5.3)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd frontend-gambitGame
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the game:
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── components/       # Game entities (hero, enemies)
├── core/            # Main game logic
├── screens/         # UI screens (loading, etc.)
├── widgets/         # Reusable UI widgets (controls)
├── config/          # Game constants and configuration
├── utils/           # Utilities (logger, colors)
└── main.dart        # Application entry point
```

## 🎯 Controls

### Directional Pad (Bottom Left)
- **↑** - Jump
- **←/→** - Move left/right
- **↓** - Move down (if applicable)

### Action Buttons (Bottom Right)
- **A Button** - Attack

## 🛠️ Tech Stack

- **Flutter**: Cross-platform UI framework
- **Flame**: 2D game engine for Flutter
- **Logger**: Debugging and logging utilities

## 📦 Dependencies

- `flame: ^1.23.0` - Game engine
- `logger: ^2.0.2` - Logging
- `cupertino_icons: ^1.0.8` - iOS style icons

## 🗺️ Roadmap

- [ ] Additional enemy types
- [ ] Multiple levels/stages
- [ ] Power-ups and collectibles
- [ ] Sound effects and background music
- [ ] High score system
- [ ] Mobile optimization
- [ ] Multiplayer support

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 🏗️ Building

Build for specific platforms:

```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web

# Desktop (Windows/Linux/macOS)
flutter build windows
flutter build linux
flutter build macos
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is private and not licensed for public distribution.

## 🙋 Support

For help or questions, please open an issue in the repository.

---

Built with ❤️ using Flutter and Flame
