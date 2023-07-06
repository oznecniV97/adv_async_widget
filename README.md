# adv_async_widget

Utility widgets for standard future and stream uses

## New advanced async builders

This package contains 2 utility classes:

- [AdvFutureBuilder](#advfuturebuilder)
- [AdvStreamBuilder](#advstreambuilder)

### AdvFutureBuilder

This class replace the standard `FutureBuilder` allowing you to have multiple build methods based on the connectionState.

Usage example:

- case with standard `FutureBuilder`

```dart
FutureBuilder<String>(
    future: exampleFuture,
    //old standard builder with one method for everything
    builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      if(snapshot.hasError) {
        return Text("Error: ${snapshot.error}");
      }
      return Text(snapshot.data ?? "No data");
    }
)
```

- case with `AdvFutureBuilder`

```dart
AdvFutureBuilder<String>(
    future: exampleFuture,
    //three different methods, one for each case
    onWait: (context) => CircularProgressIndicator(),
    onError: (context, error) => Text("Error: $error"),
    onData: (context, data) => Text(data ?? "No data"),
)
```

### AdvStreamBuilder

This class replace the standard `StreamBuilder` allowing you to have multiple build methods based on the connectionState.
(yeah, they're the same, but this one is for stream instead of future)

Usage example:

- case with standard `StreamBuilder`

```dart
StreamBuilder<String>(
    stream: exampleStream,
    //old standard builder with one method for everything
    builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      if(snapshot.hasError) {
        return Text("Error: ${snapshot.error}");
      }
      return Text(snapshot.data ?? "No data");
    }
)
```

- case with `AdvStreamBuilder`

```dart
AdvStreamBuilder<String>(
    stream: exampleStream,
    //three different methods, one for each case
    onWait: (context) => CircularProgressIndicator(),
    onError: (context, error) => Text("Error: $error"),
    onData: (context, data) => Text(data ?? "No data"),
)
```

## Full example

You can find a full flutter example on [pub example tab](https://pub.dev/packages/adv_async_widget/example) or inside [GitHub example](https://github.com/oznecniV97/adv_async_widget/blob/master/example/lib/main.dart)