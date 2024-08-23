import 'package:result_dart/result_dart.dart';

import '../models/asset.model.dart';
import '../models/company.model.dart';
import '../models/location.model.dart';

abstract class IAssetsDatasource {
  AsyncResult<List<CompanyModel>, Exception> fetchCompanies();
  AsyncResult<List<LocationModel>, Exception> fetchLocations(String companyId);
  AsyncResult<List<AssetModel>, Exception> fetchAssets(String companyId);
}
