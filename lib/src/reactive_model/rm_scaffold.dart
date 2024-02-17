part of '../reactive_model.dart';

final _scaffold = _Scaffold();

class _Scaffold {
  BuildContext? _context;

  ///The closest [ScaffoldMessengerState ]
  ScaffoldMessengerState get scaffoldMessengerState {
    final ctx = _context ?? RM.context ?? RM.navigate.navigatorState.context;
    return ScaffoldMessenger.of(ctx);
  }

  ///The closest [ScaffoldState]
  ScaffoldState get scaffoldState {
    final ctx = _context ?? RM.context;
    try {
      return Scaffold.of(ctx!);
    } catch (e) {
      throw Exception(
        '''
No valid BuildContext is defined yet

  Before calling any method a decedent BuildContext of Scaffold must be set.
  This can be done either:
  
  * ```dart
     onPressed: (){
      RM.scaffold.context= context;
      RM.scaffold.showBottomSheet(...);
     }
    ```
  * ```dart
     onPressed: (){
      modelRM.setState(
       (s)=> doSomeThing(),
       context:context,
       onData: (_,__){
          RM.scaffold.showBottomSheet(...);
        )
      }
     }
    ```
''',
      );
    }
  }

  set context(BuildContext context) => _context = context;

  ///Shows a [SnackBar] at the bottom of the scaffold.
  ///
  ///By default any current SnackBar will be hidden.
  ///
  ///* Required parameters:
  ///  * [snackBar]:  (positional parameter) The SnackBar to display.
  /// * optional parameters:
  ///  * [hideCurrentSnackBar]: Whether to hide the current SnackBar (if any).
  /// Default value is true.
  ///
  ///Equivalent to: [ScaffoldMessengerState.showSnackBar].
  ///
  ///Before calling any method a decedent BuildContext of Scaffold must be set.
  ///This can be done either:
  ///
  ///* ```dart
  ///   onPressed: (){
  ///    RM.scaffold.context= context;
  ///    RM.scaffold.showSnackBar(...);
  ///   }
  ///  ```
  ///* ```dart
  ///   onPressed: (){
  ///    modelRM.setState(
  ///     (s)=> doSomeThing(),
  ///     context:context,
  ///     onData: (_,__){
  ///        RM.scaffold.showSnackBar(...);
  ///      )
  ///    }
  ///   }
  ///  ```
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar<T>(
    SnackBar snackBar, {
    bool hideCurrentSnackBar = true,
  }) {
    if (hideCurrentSnackBar) {
      scaffoldMessengerState.hideCurrentSnackBar();
    }
    final r = scaffoldMessengerState.showSnackBar(snackBar);
    _context = null;
    return r;
  }

  ///Removes the current [SnackBar] by running its normal exit animation.
  ///
  ///Similar to [ScaffoldMessengerState.hideCurrentSnackBar].
  void hideCurrentSnackBar({
    SnackBarClosedReason reason = SnackBarClosedReason.hide,
  }) {
    scaffoldMessengerState.hideCurrentSnackBar(reason: reason);
  }

  ///Removes the current [SnackBar] (if any) immediately from
  ///registered [Scaffold]s.
  ///
  ///Similar to [ScaffoldMessengerState.removeCurrentSnackBar].
  void removeCurrentSnackBarm({
    SnackBarClosedReason reason = SnackBarClosedReason.remove,
  }) {
    scaffoldMessengerState.removeCurrentSnackBar(reason: reason);
  }

  ///Opens the [Drawer] (if any).
  ///
  ///Before calling any method a decedent BuildContext of Scaffold must be set.
  ///This can be done either:
  ///
  ///Equivalent to: [ScaffoldState.openDrawer].
  ///
  ///* ```dart
  ///   onPressed: (){
  ///    RM.scaffold.context= context;
  ///    RM.scaffold.openDrawer();
  ///   }
  ///  ```
  ///* ```dart
  ///   onPressed: (){
  ///    modelRM.setState(
  ///     (s)=> doSomeThing(),
  ///     context:context,
  ///     onData: (_,__){
  ///        RM.scaffold.openDrawer();
  ///      )
  ///    }
  ///   }
  ///  ```
  void openDrawer<T>() {
    scaffoldState.openDrawer();
    _context = null;
  }

  ///Opens the end side [Drawer] (if any).
  ///
  ///Before calling any method a decedent BuildContext of Scaffold must be set.
  ///This can be done either:
  ///
  //Equivalent to: [ScaffoldState.openEndDrawer].
  ///
  ///* ```dart
  ///   onPressed: (){
  ///    RM.scaffold.context= context;
  ///    RM.scaffold.openEndDrawer();
  ///   }
  ///  ```
  ///* ```dart
  ///   onPressed: (){
  ///    modelRM.setState(
  ///     (s)=> doSomeThing(),
  ///     context:context,
  ///     onData: (_,__){
  ///        RM.scaffold.openEndDrawer();
  ///      )
  ///    }
  ///   }
  ///  ```
  void openEndDrawer<T>() {
    scaffoldState.openEndDrawer();
    _context = null;
  }
}
