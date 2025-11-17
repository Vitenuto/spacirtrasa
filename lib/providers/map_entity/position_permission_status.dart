import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../generated/map_entity/position_permission_status.g.dart';

@riverpod
class PositionPermissionStatusProvider extends _$PositionPermissionStatusProvider {
  @override
  ServiceStatus? build() {
    logger.t("Building PositionPermissionStatus provider...");
    final sub = (Geolocator.getServiceStatusStream()).listen(_onServiceStatusUpdate);
    ref.onDispose(() => sub.cancel());
    return null;
  }

  void _onServiceStatusUpdate(ServiceStatus serviceStatus) {
    logger.t("New Geolocator's ServiceStatus: $serviceStatus");
    state = serviceStatus;
  }
}
