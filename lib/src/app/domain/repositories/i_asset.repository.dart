import 'package:result_dart/result_dart.dart';

import '../entities/asset.entity.dart';
import '../entities/company.entity.dart';
import '../entities/location.entity.dart';

abstract class IAssetRepository {
  AsyncResult<List<CompanyEntity>, Exception> fetchCompanies();
  AsyncResult<List<LocationEntity>, Exception> fetchLocations(String companyId);
  AsyncResult<List<AssetEntity>, Exception> fetchAssets(String companyId);
}
