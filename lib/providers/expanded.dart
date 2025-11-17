import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/utils/utils.dart';

part 'generated/expanded.g.dart';

@riverpod
class ExpandedProvider extends _$ExpandedProvider {
  @override
  bool build() {
    logger.t("Building Expanded provider...");
    return false;
  }

  void setExpanded(bool expanded) {
    logger.t("Setting expanded: $expanded");
    state = expanded;
  }
}
