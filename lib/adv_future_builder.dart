import 'package:flutter/material.dart';

class AdvFutureBuilder<T> extends StatelessWidget {

	final Future<T> future;
	final T initialData;

	final Widget Function(BuildContext context) onWait;
	final Widget Function(BuildContext context, Object error) onError;
	final Widget Function(BuildContext context, T data) onData;

	const AdvFutureBuilder({
		Key key,
		this.future,
		this.initialData,
		this.onWait,
		this.onError, //TODO se null?
		this.onData, //TODO se null?
	}) : super(key: key);

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
					return onWait==null ? Container() : onWait(context);
				//done case, running onError or onData depending on future status
				case ConnectionState.done:
					return snapshot.hasError? onError(context, snapshot.error) : onData(context, snapshot.data);
			}
			//impossible return, only for warning suppression
			return null;
		},
	);
}
