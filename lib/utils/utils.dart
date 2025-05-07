import 'package:flutter/material.dart';

void showFullDialog(BuildContext context, final Widget child) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog.fullscreen(child: child),
  );
}
