import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:mobile/src/clean_arch/controller.dart';
import 'package:mobile/src/utility/APIProvider.dart';
import 'package:mobile/src/utility/LoggerUtil.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:provider/provider.dart';

/// The [ViewState] represents the [State] of a [StatefulWidget], typically of a screen or a
/// page. The [ViewState] requires a [Controller] to handle its events and provide its data.
///
/// The [ViewState] also has a default [globalKey] that can be used inside its `build()` function
/// in a widget to grant easy access to the [Controller], which could then use it to display
/// snackbars, dialogs, and so on.
///
/// The [ViewState] lifecycle is also handled by the [Controller].
/// ```dart
///     class CounterState extends ViewState<CounterPage, CounterController> {
///       CounterState(CounterController controller) : super(controller);
///
///       @override
///       Widget build(BuildContext context) {
///         return MaterialApp(
///           title: 'Flutter Demo',
///           home: Scaffold(
///             key: globalKey, // using the built-in global key of the `View` for the scaffold or any other
///                             // widget provides the controller with a way to access them via getContext(), getState(), getStateKey()
///             body: Column(
///               children: <Widget>[
///                 Center(
///                   // show the number of times the button has been clicked
///                   child: Text(controller.counter.toString()),
///                 ),
///                 // you can refresh manually inside the controller
///                 // using refreshUI()
///                 MaterialButton(onPressed: controller.increment),
///               ],
///             ),
///           ),
///         );
///       }
///     }
///
/// ```
abstract class ViewState<Page extends View, Con extends Controller>
    extends State<Page> {
  final GlobalKey<State<StatefulWidget>> globalKey =
      GlobalKey<State<StatefulWidget>>();
  Con _controller;
  Logger _logger;
  Con get controller => _controller;
  ViewState(this._controller) {
    _controller.initController(globalKey);
    WidgetsBinding.instance.addObserver(_controller);
    _logger = LoggerUtil().logger;
  }
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
//     progressSubject.listen((event) {
//       print("------> $event"); // t
//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Alert Dialog ${event}"),
//               content: Text("Dialog Content"),
//             );
//           });
//     });
    Utils.isInternetConnected().then((internet) {
      onConnectivityListener(internet);
    });
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi)
        onConnectivityListener(true);
      else
        onConnectivityListener(false);
      LoggerUtil().logger.d("Connectivity: " + result.toString());
    });
  }

  @override
  @mustCallSuper
  void didChangeDependencies() {
    if (widget.routeObserver != null) {
      _logger.i('$runtimeType is observring route events.');
      widget.routeObserver.subscribe(_controller, ModalRoute.of(context));
    }

    super.didChangeDependencies();
  }

  Widget buildPage();

  void onConnectivityListener(bool internet);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Con>.value(
        value: _controller,
        child: Consumer<Con>(builder: (ctx, con, _) {
          _controller = con;
          return buildPage();
        }));
  }

  @override
  @mustCallSuper
  void dispose() {
    _logger.i('Disposing $runtimeType.');
    _controller.dispose();
    subscription.cancel();
    super.dispose();
  }
}

/// The [View] represents a [StatefulWidget]. The [View] is typically a page or screen in
/// the application. However, a [View] can be any [StatefulWidget]. The [View] must have a
/// [State], and that [State] should be of type [ViewState<MyView, MyController>].
///
/// If a [RouteObserver] is given to the [View], it is used to register its [Controller] as
/// a subscriber, which provides the ability to listen to push and pop route events.
/// ```dart
///   class CounterPage extends View {
///     CounterPage({RouteObserver observer, Key key}): super(routeObserver: routeObserver, key: key);
///     @override
///     // Dependencies can be injected here
///     State<StatefulWidget> createState() => CounterState(Controller());
///   }
///
/// ```
///
abstract class View extends StatefulWidget {
  final RouteObserver routeObserver;
  final Key key;
  View({this.routeObserver, this.key}) : super(key: key);
}
