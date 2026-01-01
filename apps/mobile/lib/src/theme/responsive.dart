import 'package:flutter/material.dart';

enum AppBreakpoint { compact, medium, expanded }

class ResponsiveBreakpoints {
  const ResponsiveBreakpoints._();

  static const double _compactMaxWidth = 599;
  static const double _mediumMaxWidth = 1023;

  static AppBreakpoint fromSize(Size size) {
    if (size.width <= _compactMaxWidth) {
      return AppBreakpoint.compact;
    }
    if (size.width <= _mediumMaxWidth) {
      return AppBreakpoint.medium;
    }
    return AppBreakpoint.expanded;
  }

  static AppBreakpoint of(BuildContext context) =>
      fromSize(MediaQuery.of(context).size);

  static bool isCompact(BuildContext context) =>
      of(context) == AppBreakpoint.compact;

  static bool isMediumOrLarger(BuildContext context) {
    final breakpoint = of(context);
    return breakpoint == AppBreakpoint.medium ||
        breakpoint == AppBreakpoint.expanded;
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
  });

  final WidgetBuilder compact;
  final WidgetBuilder? medium;
  final WidgetBuilder? expanded;

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    switch (breakpoint) {
      case AppBreakpoint.compact:
        return compact(context);
      case AppBreakpoint.medium:
        return (medium ?? compact)(context);
      case AppBreakpoint.expanded:
        return (expanded ?? medium ?? compact)(context);
    }
  }
}
