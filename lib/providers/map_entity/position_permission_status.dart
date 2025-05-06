import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/map_entity/position_permission_status.g.dart';

@riverpod
class PositionPermissionStatusProvider extends _$PositionPermissionStatusProvider {
  static final log = Logger();

  @override
  ServiceStatus? build() {
    log.t("Building PositionPermissionStatus provider...");
    final sub = (Geolocator.getServiceStatusStream()).listen(_onServiceStatus);
    ref.onDispose(() => sub.cancel());
    return null;
  }

  void _onServiceStatus(ServiceStatus serviceStatus) {
    log.t("New Geolocator's ServiceStatus: $serviceStatus");
    state = serviceStatus;
  }
}
