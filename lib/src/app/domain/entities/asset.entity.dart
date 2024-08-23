import '../enums/component_sensor_type.enum.dart';
import '../enums/component_status.enum.dart';

class AssetEntity {
  final String id;
  final String name;

  final String? parentId;
  final String? sensorId;
  final String? gatewayId;
  final String? locationId;

  final ComponentSensorTypeEnum? sensorType;
  final ComponentStatusEnum? status;

  const AssetEntity({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    this.gatewayId,
    this.locationId,
    this.sensorType,
    this.status,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssetEntity &&
        other.id == id &&
        other.name == name &&
        other.parentId == parentId &&
        other.sensorId == sensorId &&
        other.gatewayId == gatewayId &&
        other.locationId == locationId &&
        other.sensorType == sensorType &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        (parentId?.hashCode ?? 0) ^
        (sensorId?.hashCode ?? 0) ^
        (gatewayId?.hashCode ?? 0) ^
        (locationId?.hashCode ?? 0) ^
        (sensorType?.hashCode ?? 0) ^
        (status?.hashCode ?? 0);
  }

  @override
  String toString() {
    return 'AssetEntity(id: $id, name: $name, parentId: ${parentId ?? 'none'}, sensorId: ${sensorId ?? 'none'}, gatewayId: ${gatewayId ?? 'none'}, locationId: ${locationId ?? 'none'}, sensorType: ${sensorType?.toString() ?? 'none'}, status: ${status?.toString() ?? 'none'})';
  }
}
