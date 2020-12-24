import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  @override
  void log(Level level, message, error, StackTrace stackTrace) {
    return message;
  }
}