import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Global logger instance for the application
final Logger gameLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
  level: kDebugMode ? Level.debug : Level.warning,
);

/// Extension methods for easier logging
extension LoggerExtension on Logger {
  /// Log debug information (only in debug mode)
  void debug(String message) {
    if (kDebugMode) {
      d(message);
    }
  }

  /// Log game events
  void gameEvent(String event, [dynamic data]) {
    if (kDebugMode) {
      i('🎮 $event${data != null ? ': $data' : ''}');
    }
  }

  /// Log player actions
  void playerAction(String action) {
    if (kDebugMode) {
      i('👤 Player: $action');
    }
  }

  /// Log enemy actions
  void enemyAction(String action) {
    if (kDebugMode) {
      i('👾 Enemy: $action');
    }
  }
}
