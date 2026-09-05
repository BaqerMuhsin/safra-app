import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.backgroundColor,
    this.useGradientBackground = true,
    this.gradient,
    this.resizeToAvoidBottomInset = true,
    this.systemUiOverlayStyle = SystemUiOverlayStyle.dark,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBody;
  final Color? backgroundColor;
  final bool useGradientBackground;
  final Gradient? gradient;
  final bool resizeToAvoidBottomInset;
  final SystemUiOverlayStyle systemUiOverlayStyle;

  static Gradient get defaultGradient => AppTheme.scaffoldGradient;

  @override
  Widget build(BuildContext context) {
    final useGradient = useGradientBackground && backgroundColor == null;
    final resolvedGradient = gradient ?? defaultGradient;
    final fillColor = backgroundColor ?? AppTheme.background;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: DecoratedBox(
        decoration: useGradient
            ? BoxDecoration(gradient: resolvedGradient)
            : BoxDecoration(color: fillColor),
        child: Scaffold(
          appBar: appBar,
          extendBody: extendBody,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          backgroundColor: Colors.transparent,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
        ),
      ),
    );
  }
}
