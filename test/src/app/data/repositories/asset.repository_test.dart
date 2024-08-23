import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:treeview_challenge/src/app/domain/entities/asset.entity.dart';
import 'package:treeview_challenge/src/app/domain/entities/company.entity.dart';
import 'package:treeview_challenge/src/app/domain/entities/location.entity.dart';
import 'package:treeview_challenge/src/app/domain/enums/component_sensor_type.enum.dart';
import 'package:treeview_challenge/src/app/domain/repositories/i_asset.repository.dart';

class MockAssetRepository extends Mock implements IAssetRepository {}

void main() {
  late MockAssetRepository repository;

  setUp(() {
    repository = MockAssetRepository();
  });

  group('IAssetRepository Tests', () {
    test('fetchCompanies returns a list of companies', () async {
      final companyList = [
        const CompanyEntity(id: '1', name: 'Company 1'),
        const CompanyEntity(id: '2', name: 'Company 2'),
      ];
      when(() => repository.fetchCompanies())
          .thenAnswer((_) async => Result.success(companyList));

      final result = await repository.fetchCompanies();

      expect(result.isSuccess(), true);
      expect(result.getOrThrow(), companyList);
    });

    test('fetchLocations returns a list of locations for a given companyId',
        () async {
      final locationList = [
        const LocationEntity(id: '1', name: 'Location 1'),
        const LocationEntity(id: '2', name: 'Location 2'),
      ];
      when(() => repository.fetchLocations('1'))
          .thenAnswer((_) async => Result.success(locationList));

      final result = await repository.fetchLocations('1');

      expect(result.isSuccess(), true);
      expect(result.getOrThrow(), locationList);
    });

    test('fetchAssets returns a list of assets for a given companyId',
        () async {
      final assetList = [
        const AssetEntity(id: '1', name: 'Asset 1'),
        const AssetEntity(id: '2', name: 'Asset 2'),
      ];
      when(() => repository.fetchAssets('1'))
          .thenAnswer((_) async => Result.success(assetList));

      final result = await repository.fetchAssets('1');

      expect(result.isSuccess(), true);
      expect(result.getOrThrow(), assetList);
    });
  });

  group('Tree View Logic Tests', () {
    test('Filters out non-relevant assets', () async {
      final assetList = [
        const AssetEntity(
            id: '1',
            name: 'Asset 1',
            sensorType: ComponentSensorTypeEnum.energy),
        const AssetEntity(
            id: '2',
            name: 'Asset 2',
            sensorType: ComponentSensorTypeEnum.vibration),
      ];
      final filteredAssetList = [
        const AssetEntity(
            id: '1',
            name: 'Asset 1',
            sensorType: ComponentSensorTypeEnum.energy),
      ];

      when(() => repository.fetchAssets('1'))
          .thenAnswer((_) async => Result.success(assetList));

      final result = await repository.fetchAssets('1');

      final filteredResult = result
          .getOrThrow()
          .where((asset) => asset.sensorType == ComponentSensorTypeEnum.energy)
          .toList();

      expect(filteredResult, filteredAssetList);
    });

    test('Search functionality within assets', () async {
      final assetList = [
        const AssetEntity(id: '1', name: 'Searchable Asset'),
        const AssetEntity(id: '2', name: 'Another Asset'),
      ];
      final searchResult = [
        const AssetEntity(id: '1', name: 'Searchable Asset'),
      ];

      when(() => repository.fetchAssets('1'))
          .thenAnswer((_) async => Result.success(assetList));

      final result = await repository.fetchAssets('1');

      final searchResult2 = result
          .getOrThrow()
          .where((asset) => asset.name.contains('Searchable'))
          .toList();

      expect(searchResult, searchResult2);
    });
  });

  group('Entity Tests', () {
    test('AssetEntity equality', () {
      const asset1 = AssetEntity(id: '1', name: 'Asset 1');
      const asset2 = AssetEntity(id: '1', name: 'Asset 1');

      expect(asset1, equals(asset2));
    });

    test('CompanyEntity equality', () {
      const company1 = CompanyEntity(id: '1', name: 'Company 1');
      const company2 = CompanyEntity(id: '1', name: 'Company 1');

      expect(company1, equals(company2));
    });
  });
}
