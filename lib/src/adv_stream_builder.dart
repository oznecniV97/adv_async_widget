import 'package:adv_async_widget/src/utils.dart';
import 'package:flutter/material.dart';

class AdvStreamBuilder<T> extends StatelessWidget {
  ///See [StreamBuilderBase.stream] for information
  final Stream<T> stream;

  ///See [StreamBuilder.initialData] for information
  final T initialData;

  ///Callback invoked when [stream] is not null and it's finished ([ConnectionState.done]), passing data object, or if [stream] is null, passing data null
  final Widget Function(BuildContext context, T data) onData;

  ///Callback invoked when [stream] is not null, before it will finish
  final Widget Function(BuildContext context) onWait;

  ///Callback invoked if [stream] is not null and it ends in error
  final Widget Function(BuildContext context, Object error) onError;

  const AdvStreamBuilder({
    Key key,
    this.stream,
    this.initialData,
    @required this.onData,
    this.onWait,
    this.onError,
  })  : assert(onData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<T>(
        stream: stream,
        initialData: initialData,
        builder: advAsyncBuilder(onData, onWait, onError),
      );
}
