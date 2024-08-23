import '../../common/generics/mapper.generic.dart';
import '../../domain/entities/location.entity.dart';
import '../models/location.model.dart';

class LocationMapper extends Mapper<LocationModel, LocationEntity> {
  @override
  LocationEntity toEntity(LocationModel model) {
    return LocationEntity(
      id: model.id,
      name: model.name,
      parentId: model.parentId,
    );
  }

  @override
  LocationModel toModel(LocationEntity entity) {
    return LocationModel(
      id: entity.id,
      name: entity.name,
      parentId: entity.parentId,
    );
  }
}
