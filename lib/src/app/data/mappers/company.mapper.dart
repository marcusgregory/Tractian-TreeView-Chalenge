import '../../common/generics/mapper.generic.dart';
import '../../domain/entities/company.entity.dart';
import '../models/company.model.dart';

class CompanyMapper extends Mapper<CompanyModel, CompanyEntity> {
  @override
  CompanyEntity toEntity(CompanyModel model) {
    return CompanyEntity(
      id: model.id,
      name: model.name,
    );
  }

  @override
  CompanyModel toModel(CompanyEntity entity) {
    return CompanyModel(
      id: entity.id,
      name: entity.name,
    );
  }
}
