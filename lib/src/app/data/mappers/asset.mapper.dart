import '../../common/generics/mapper.generic.dart';
import '../../domain/entities/asset.entity.dart';
import '../../domain/enums/component_sensor_type.enum.dart';
import '../../domain/enums/component_status.enum.dart';
import '../models/asset.model.dart';

class AssetMapper extends Mapper<AssetModel, AssetEntity> {
  @override
  AssetEntity toEntity(AssetModel model) {
    return AssetEntity(
      id: model.id,
      name: model.name,
      gatewayId: model.gatewayId,
      locationId: model.locationId,
      parentId: model.parentId,
      sensorId: model.sensorId,
      sensorType: model.sensorType == null
          ? null
          : ComponentSensorTypeEnum.fromName(model.sensorType!),
      status: model.status == null
          ? null
          : ComponentStatusEnum.fromName(model.status!),
    );
  }

  @override
  AssetModel toModel(AssetEntity entity) {
    return AssetModel(
      id: entity.id,
      name: entity.name,
      gatewayId: entity.gatewayId,
      locationId: entity.locationId,
      parentId: entity.parentId,
      sensorId: entity.sensorId,
      sensorType: entity.sensorType?.name,
      status: entity.status?.name,
    );
  }
}
