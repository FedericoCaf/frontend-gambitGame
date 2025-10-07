import 'package:flutter/foundation.dart';
import 'package:gambit_game/utils/logger.dart';

/// Service for managing hero statistics, particularly health/hearts
class HeroStatsService extends ChangeNotifier {
  // Private singleton instance
  static final HeroStatsService _instance = HeroStatsService._internal();

  // Factory constructor to return the singleton instance
  factory HeroStatsService() {
    return _instance;
  }

  // Private constructor
  HeroStatsService._internal();

  // ================== Health/Hearts Management ==================

  int _maxHearts = 5;
  int _currentHearts = 5;

  /// Maximum number of hearts the hero can have
  int get maxHearts => _maxHearts;

  /// Current number of hearts the hero has
  int get currentHearts => _currentHearts;

  /// Whether the hero is alive
  bool get isAlive => _currentHearts > 0;

  /// Health percentage (0.0 to 1.0)
  double get healthPercentage => _currentHearts / _maxHearts;

  /// Take damage and reduce hearts
  void takeDamage(int damage) {
    if (_currentHearts > 0) {
      _currentHearts = (_currentHearts - damage).clamp(0, _maxHearts);
      notifyListeners();

      if (_currentHearts == 0) {
        _onDeath();
      }
    }
  }

  /// Heal and restore hearts
  void heal(int amount) {
    if (_currentHearts < _maxHearts) {
      _currentHearts = (_currentHearts + amount).clamp(0, _maxHearts);
      notifyListeners();
    }
  }

  /// Fully restore all hearts
  void fullHeal() {
    _currentHearts = _maxHearts;
    notifyListeners();
  }

  /// Increase maximum hearts capacity
  void increaseMaxHearts(int amount) {
    _maxHearts += amount;
    _currentHearts += amount; // Also heal by the same amount
    notifyListeners();
  }

  /// Decrease maximum hearts capacity
  void decreaseMaxHearts(int amount) {
    _maxHearts = (_maxHearts - amount).clamp(1, double.infinity.toInt());
    _currentHearts = _currentHearts.clamp(0, _maxHearts);
    notifyListeners();
  }

  /// Reset hearts to initial state
  void reset() {
    _maxHearts = 5;
    _currentHearts = 5;
    notifyListeners();
  }

  /// Internal death handler
  void _onDeath() {
    // Can be extended with death callbacks
    gameLogger.debug('Hero has died!');
  }

  // ================== Future Statistics ==================
  // Add more statistics as needed (stamina, mana, experience, etc.)

  /// Attack power
  int _attackPower = 10;
  int get attackPower => _attackPower;

  void increaseAttackPower(int amount) {
    _attackPower += amount;
    notifyListeners();
  }

  /// Defense
  int _defense = 5;
  int get defense => _defense;

  void increaseDefense(int amount) {
    _defense += amount;
    notifyListeners();
  }

  /// Speed multiplier
  double _speedMultiplier = 1.0;
  double get speedMultiplier => _speedMultiplier;

  void setSpeedMultiplier(double multiplier) {
    _speedMultiplier = multiplier.clamp(0.1, 5.0);
    notifyListeners();
  }
}
