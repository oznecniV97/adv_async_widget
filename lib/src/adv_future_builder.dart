import 'package:adv_async_widget/src/utils.dart';
import 'package:flutter/material.dart';

class AdvFutureBuilder<T> extends StatelessWidget {

	///See [FutureBuilder.future] for information
	final Future<T> future;
	///See [FutureBuilder.initialData] for information
	final T initialData;

	///Callback invoked when [future] is not null and it's finished ([ConnectionState.done]), passing data object, or if [future] is null, with data null
	final Widget Function(BuildContext context, T data) onData;
	///Callback invoked when [future] is not null, before it will finish
	final Widget Function(BuildContext context) onWait;
	///Callback invoked if [future] is not null and it ends in error
	final Widget Function(BuildContext context, Object error) onError;

	const AdvFutureBuilder({
		Key key,
		this.future,
		this.initialData,
		@required this.onData,
		this.onWait,
		this.onError,
	}) : assert(onData!=null), super(key: key);

	@override
	Widget build(BuildContext context) => FutureBuilder<T>(
		future: future,
		initialData: initialData,
		builder: (context, snapshot) {
			switch(snapshot.connectionState) {
				//future null case
				case ConnectionState.none:
					return onData(context, null);
				//waiting case
				case ConnectionState.waiting:
				case ConnectionState.active:
					return optionalWidgetPrint(onWait==null, () => onWait(context));
				//done case, running onError or onData depending on future status
				case ConnectionState.done:
					return snapshot.hasError? optionalWidgetPrint(onError==null, () => onError(context, snapshot.error)) : onData(context, snapshot.data);
			}
			//impossible return, only for warning suppression
			return null;
		},
	);
}
