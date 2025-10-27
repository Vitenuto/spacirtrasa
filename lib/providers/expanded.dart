import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/expanded.g.dart';

@riverpod
class ExpandedProvider extends _$ExpandedProvider {
  static final _log = Logger();

  @override
  bool build() {
    _log.t("Building Expanded provider...");
    return false;
  }

  void setExpanded(bool expanded) {
    _log.t("Setting expanded: $expanded");
    state = expanded;
  }
}
