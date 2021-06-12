import 'package:flutter/widgets.dart';

AsyncWidgetBuilder<T> advAsyncBuilder<T>(
  final Widget Function(BuildContext context, T? data) onData,
  final Widget Function(BuildContext context)? onWait,
  final Widget Function(BuildContext context, Object? error)? onError,
) =>
    (context, snapshot) {
      Widget? _return;
      switch (snapshot.connectionState) {
        //future null case
        case ConnectionState.none:
          _return = onData(context, null);
          break;
        //waiting case
        case ConnectionState.waiting:
        case ConnectionState.active:
          if (onWait != null) {
            _return = onWait(context);
          }
          break;
        //done case, running onError or onData depending on future status
        case ConnectionState.done:
          if (snapshot.hasError) {
            if (onError != null) {
              _return = onError(context, snapshot.error);
            }
          } else {
            _return = onData(context, snapshot.data);
          }
          break;
      }

      //default case, if no one return set was invoked
      _return ??= Container();

      return _return;
    };
