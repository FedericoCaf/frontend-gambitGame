# Contributing to Gambit Game

Thank you for your interest in contributing to Gambit Game! This document provides guidelines and instructions for contributing.

## Code of Conduct

Please be respectful and constructive in all interactions with the project and its community.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/gambit-game.git
   cd gambit-game
   ```
3. **Install dependencies**:
   ```bash
   flutter pub get
   ```
4. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Workflow

### 1. Code Style

- Follow Dart's official [style guide](https://dart.dev/guides/language/effective-dart/style)
- Use `dart format` to format your code before committing
- The project uses strict linting rules defined in `analysis_options.yaml`

### 2. Project Structure

```
lib/
├── components/       # Game entities (hero, enemies)
├── core/            # Main game logic
├── screens/         # UI screens
├── widgets/         # Reusable UI widgets
├── config/          # Constants and configuration
└── utils/           # Utilities (logger, colors)
```

Please maintain this structure when adding new files.

### 3. Naming Conventions

- **Files**: Use `snake_case` (e.g., `hero_component.dart`)
- **Classes**: Use `PascalCase` (e.g., `HeroComponent`)
- **Variables/Methods**: Use `camelCase` (e.g., `jumpAction`)
- **Constants**: Use `SCREAMING_SNAKE_CASE` or class constants (e.g., `PhysicsConstants.gravity`)

### 4. Writing Code

- **Extract constants**: Don't use magic numbers. Add constants to `lib/config/game_constants.dart`
- **Add documentation**: Use dartdoc comments (`///`) for public APIs
- **Use the logger**: Import from `lib/utils/logger.dart` instead of using `print()`
- **Follow SOLID principles**: Keep classes focused and single-responsibility

Example:
```dart
/// Triggers the hero's jump action
void jumpAction() {
  current = HeroState.jump;
  if (isOnGround) {
    velocityY = PhysicsConstants.jumpForce;
    isOnGround = false;
    gameLogger.playerAction('Jump');
  }
}
```

### 5. Testing

- Write tests for new features
- Ensure all tests pass before submitting:
  ```bash
  flutter test
  ```
- Aim for meaningful test coverage

### 6. Before Committing

Run these commands to ensure code quality:

```bash
# Format code
dart format .

# Analyze code
flutter analyze

# Run tests
flutter test
```

## Submitting Changes

### 1. Commit Messages

Use clear, descriptive commit messages following the [Conventional Commits](https://www.conventionalcommits.org/) format:

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

Examples:
```
feat: add double jump ability to hero
fix: resolve collision detection bug with enemies
docs: update README with new controls
```

### 2. Pull Request Process

1. **Update documentation** if needed
2. **Ensure CI passes** (tests, linting, builds)
3. **Fill out the PR template** completely
4. **Link related issues** using "Closes #123"
5. **Request a review**

### 3. Pull Request Checklist

- [ ] Code follows the project's style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] All tests pass
- [ ] No new warnings

## Reporting Bugs

Use the [Bug Report template](.github/ISSUE_TEMPLATE/bug_report.md) to report bugs. Include:

- Clear description of the bug
- Steps to reproduce
- Expected vs actual behavior
- Environment details (platform, device, version)
- Screenshots if applicable

## Requesting Features

Use the [Feature Request template](.github/ISSUE_TEMPLATE/feature_request.md) to suggest features. Include:

- Description of the feature
- Problem it solves
- Proposed solution
- Alternatives considered

## Questions?

If you have questions, feel free to:
- Open an issue for discussion
- Check existing issues and PRs

Thank you for contributing to Gambit Game! 🎮
