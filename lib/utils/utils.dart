import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'constants.dart';

final log = Logger();

void showFullDialog(BuildContext context, final Widget child) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog.fullscreen(child: child),
  );
}

double get fullItemHeight => itemListHeight + (itemListPadding * 2);