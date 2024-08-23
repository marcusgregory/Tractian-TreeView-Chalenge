import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:treeview_challenge/src/app/data/datasources/assets.datasource.dart';
import 'package:treeview_challenge/src/app/presentation/controllers/asset_tree.controller.dart';
import 'package:treeview_challenge/src/app/shared/constants/constants.dart';
import '../../shared/generics/mapper.generic.dart';
import '../datasources/i_assets.datasource.dart';
import '../mappers/asset.mapper.dart';
import '../mappers/company.mapper.dart';
import '../mappers/location.mapper.dart';
import '../models/asset.model.dart';
import '../models/company.model.dart';
import '../models/location.model.dart';
import '../repositories/asset.repository.dart';
import '../../domain/entities/asset.entity.dart';
import '../../domain/entities/company.entity.dart';
import '../../domain/entities/location.entity.dart';
import '../../domain/repositories/i_asset.repository.dart';
import '../../presentation/controllers/company_list.controller.dart';

class AppDependencyInjection implements Bindings {
  @override
  void dependencies() {
    // Register HTTP client
    Get.put<Client>(Client());

    // Register data sources
    Get.put<IAssetsDatasource>(
      AssetsDatasource(
        Constants.apiUrl,
        Get.find<Client>(),
      ),
    );

    // Register mappers
    Get.put<Mapper<AssetModel, AssetEntity>>(AssetMapper());
    Get.put<Mapper<CompanyModel, CompanyEntity>>(CompanyMapper());
    Get.put<Mapper<LocationModel, LocationEntity>>(LocationMapper());

    // Register repository
    Get.put<IAssetRepository>(
      AssetRepository(
        Get.find<IAssetsDatasource>(),
        Get.find<Mapper<AssetModel, AssetEntity>>(),
        Get.find<Mapper<CompanyModel, CompanyEntity>>(),
        Get.find<Mapper<LocationModel, LocationEntity>>(),
      ),
    );

    // Register controllers
    Get.put<CompanyListController>(
      CompanyListController(
        Get.find<IAssetRepository>(),
      ),
    );

    Get.put<AssetTreeController>(
      AssetTreeController(
        Get.find<IAssetRepository>(),
      ),
    );
  }
}
