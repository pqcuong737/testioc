import 'package:logger/logger.dart';

class LoggerUtil{

  static final LoggerUtil _loggerUtil = LoggerUtil._internal();
  Logger _logger;
  Logger get logger => _logger;

  factory LoggerUtil(){
    return _loggerUtil;
  }

  LoggerUtil._internal();


  /// Enables logging inside the `LoggerUtil` package,
   void debugModeOn() {
     _logger = Logger(printer: PrettyPrinter(
         colors: true,
         errorMethodCount: 1,
         printEmojis: true,
         printTime: true,
         lineLength: 80,
         methodCount: 0
     ));
   }

}