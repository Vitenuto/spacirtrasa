import 'package:flutter/material.dart';

typedef ButtonBuilder =
    Widget Function({
      required VoidCallback? onPressed,
      required Widget child,
      VoidCallback? onLongPress,
      ButtonStyle? style,
    });

// Copied from async_button_handler package
class AsyncButtonHandler<T> extends StatefulWidget {
  final T Function() onPressed;
  final T Function()? onLongPress;
  final Widget? loadingChild;
  final Widget? child;
  final ButtonStyle? style;
  final bool overlayLoading;
  final ButtonBuilder builder;

  const AsyncButtonHandler({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.loadingChild,
    this.child,
    this.style,
    this.overlayLoading = false,
    required this.builder,
  });

  @override
  State<AsyncButtonHandler<T>> createState() => _AsyncButtonHandlerState<T>();
}

class _AsyncButtonHandlerState<T> extends State<AsyncButtonHandler<T>> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      style: widget.style ?? OutlinedButton.styleFrom(minimumSize: const Size(200, 48)),
      onPressed: isLoading ? null : () => _handlePressBehavior(context, widget.onPressed),
      onLongPress:
          isLoading || widget.onLongPress == null
              ? null
              : () => _handlePressBehavior(context, widget.onLongPress!),
      child:
          isLoading
              ? widget.loadingChild ?? const CircularProgressIndicator()
              : widget.child ?? const Text('Button'),
    );
  }

  void _handlePressBehavior(BuildContext context, Function() action) async {
    final isAsync = action is Future Function();
    if (isAsync) {
      if (!widget.overlayLoading) {
        setState(() => isLoading = true);
        await runActionSafely(action);
        if (mounted) setState(() => isLoading = false);
      } else {
        _showOverlayLoading(context);
        await runActionSafely(action);
        if (context.mounted) _hideOverlayLoading(context);
      }
    } else {
      action();
    }
  }

  Future<dynamic> runActionSafely(Function() action) async {
    try {
      return await (action as Future Function())();
    } catch (e) {
      // Ignore exceptions here, they should be handled by the caller
    }
  }

  void _showOverlayLoading(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => PopScope(
            canPop: false,
            child: Center(child: widget.loadingChild ?? const CircularProgressIndicator()),
          ),
    );
  }

  void _hideOverlayLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}

class OutlinedAsyncButton extends StatelessWidget {
  const OutlinedAsyncButton({
    super.key,
    this.style,
    required this.onPressed,
    required this.child,
    this.onLongPress,
  });

  final ButtonStyle? style;
  final Future<void> Function() onPressed;
  final Future<void> Function()? onLongPress;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AsyncButtonHandler(
      style: style,
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: child,
      builder:
          ({required onPressed, required child, onLongPress, style}) => OutlinedButton(
            onPressed: onPressed,
            onLongPress: onLongPress,
            style: style,
            child: child,
          ),
    );
  }
}

class ElevatedAsyncButton extends StatelessWidget {
  const ElevatedAsyncButton({
    super.key,
    this.style,
    required this.onPressed,
    required this.child,
    this.onLongPress,
  });

  final ButtonStyle? style;
  final Future<void> Function() onPressed;
  final Future<void> Function()? onLongPress;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AsyncButtonHandler(
      style: style,
      onPressed: onPressed,
      child: child,
      builder:
          ({required onPressed, required child, onLongPress, style}) => ElevatedButton(
            onPressed: onPressed,
            onLongPress: onLongPress,
            style: style,
            child: child,
          ),
    );
  }
}
