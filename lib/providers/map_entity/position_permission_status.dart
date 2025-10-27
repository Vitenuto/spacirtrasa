import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/map_entity/position_permission_status.g.dart';

@riverpod
class PositionPermissionStatusProvider extends _$PositionPermissionStatusProvider {
  static final _log = Logger();

  @override
  ServiceStatus? build() {
    _log.t("Building PositionPermissionStatus provider...");
    final sub = (Geolocator.getServiceStatusStream()).listen(_onServiceStatusUpdate);
    ref.onDispose(() => sub.cancel());
    return null;
  }

  void _onServiceStatusUpdate(ServiceStatus serviceStatus) {
    _log.t("New Geolocator's ServiceStatus: $serviceStatus");
    state = serviceStatus;
  }
}
