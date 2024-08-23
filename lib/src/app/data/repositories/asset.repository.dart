import 'package:result_dart/result_dart.dart';

import '../../common/generics/mapper.generic.dart';
import '../../domain/entities/asset.entity.dart';
import '../../domain/entities/company.entity.dart';
import '../../domain/entities/location.entity.dart';
import '../../domain/repositories/i_asset.repository.dart';
import '../datasources/i_assets.datasource.dart';
import '../models/asset.model.dart';
import '../models/company.model.dart';
import '../models/location.model.dart';

class AssetRepository implements IAssetRepository {
  const AssetRepository(
    this._dataSource,
    this._assetMapper,
    this._companyMapper,
    this._locationMapper,
  );

  final IAssetsDatasource _dataSource;
  final Mapper<AssetModel, AssetEntity> _assetMapper;
  final Mapper<CompanyModel, CompanyEntity> _companyMapper;
  final Mapper<LocationModel, LocationEntity> _locationMapper;

  @override
  AsyncResult<List<AssetEntity>, Exception> fetchAssets(
      String companyId) async {
    try {
      final result = await _dataSource.fetchAssets(companyId);

      return result.flatMap(
        (assets) => Success(_assetMapper.toEntities(assets)),
      );
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<List<CompanyEntity>, Exception> fetchCompanies() async {
    try {
      final result = await _dataSource.fetchCompanies();

      return result.flatMap(
        (companies) => Success(_companyMapper.toEntities(companies)),
      );
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<List<LocationEntity>, Exception> fetchLocations(
      String companyId) async {
    try {
      final result = await _dataSource.fetchLocations(companyId);

      return result.flatMap(
        (locations) => Success(_locationMapper.toEntities(locations)),
      );
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
