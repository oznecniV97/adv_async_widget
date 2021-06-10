import 'package:flutter/widgets.dart';

Widget optionalWidgetPrint(bool print, Widget Function() widget) =>
    print ? widget() : Container();

AsyncWidgetBuilder<T> advAsyncBuilder<T>(
  final Widget Function(BuildContext context, T data) onData,
  final Widget Function(BuildContext context) onWait,
  final Widget Function(BuildContext context, Object error) onError,
) {
  return (context, snapshot) {
    switch (snapshot.connectionState) {
      //future null case
      case ConnectionState.none:
        return onData(context, null);
      //waiting case
      case ConnectionState.waiting:
      case ConnectionState.active:
        return optionalWidgetPrint(onWait != null, () => onWait(context));
      //done case, running onError or onData depending on future status
      case ConnectionState.done:
        return snapshot.hasError
            ? optionalWidgetPrint(
                onError != null, () => onError(context, snapshot.error))
            : onData(context, snapshot.data);
    }
    //impossible return, only for warning suppression
    return null;
  };
}
