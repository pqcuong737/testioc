library flutter_clean_architecture;

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile/src/clean_arch/controller.dart';
import 'package:provider/provider.dart';

class FlutterCleanArchitecture {
  /// Retrieves a Controller from the widget tree if one exists
  /// Can be used in widgets that exist in pages and need to use the same controller
  static Con getController<Con extends Controller>(BuildContext context) {
    return Provider.of<Con>(context);
  }
}
