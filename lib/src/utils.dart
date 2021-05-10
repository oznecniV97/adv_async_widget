import 'package:flutter/widgets.dart';

optionalWidgetPrint(bool print, Widget Function() widget) => print ? Container() : widget();
