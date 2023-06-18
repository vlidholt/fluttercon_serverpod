import 'package:flutter/material.dart';

abstract class SlickTransition {
  const SlickTransition();

  PageRoute buildPageRoute(WidgetBuilder slideBuilder);
}
