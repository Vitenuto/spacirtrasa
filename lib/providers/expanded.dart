import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/expanded.g.dart';

@riverpod
class ExpandedProvider extends _$ExpandedProvider {
  static final log = Logger();

  @override
  bool build() {
    log.t("Building Expanded provider...");
    return false;
  }

  void setExpanded(bool expanded) {
    log.t("Setting expanded: $expanded");
    state = expanded;
  }
}
