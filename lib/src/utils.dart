import 'package:flutter/widgets.dart';

AsyncWidgetBuilder<T> advAsyncBuilder<T>(
  final Widget Function(BuildContext context, T? data) onData,
  final Widget Function(BuildContext context)? onWait,
  final Widget Function(BuildContext context, Object? error)? onError,
  [
    Widget Function(BuildContext context, T? data)? onActive,
  ]
) =>
    (context, snapshot) {
      //set onActive equals to onData if is not present
      onActive ??= onData;

      Widget? _return;
      switch (snapshot.connectionState) {
        //future null case
        case ConnectionState.none:
          _return = onData(context, null);
          break;
        //waiting case
        case ConnectionState.waiting:
          if (onWait != null) {
            _return = onWait(context);
          }
          break;
        //active case, stream enabled and ready to receive data
        case ConnectionState.active:
          _return = _checkError(context, snapshot, onActive!, onError);
          break;
        //done case, running onError or onData depending on error presence
        case ConnectionState.done:
          _return = _checkError(context, snapshot, onData, onError);
          break;
      }

      //default case, if no one return set was invoked
      _return ??= Container();

      return _return;
    };

Widget? _checkError<T>(
    BuildContext context,
    AsyncSnapshot<T> snapshot,
    final Widget Function(BuildContext context, T? data) onData,
    final Widget Function(BuildContext context, Object? error)? onError,
) {
  if (snapshot.hasError) {
    if (onError != null) {
      return onError(context, snapshot.error);
    }
    return null;
  }
  return onData(context, snapshot.data);
}