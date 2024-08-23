import 'dart:convert';

import 'package:http/http.dart';
import 'package:result_dart/result_dart.dart';

import '../models/asset.model.dart';
import '../models/company.model.dart';
import '../models/location.model.dart';
import 'i_assets.datasource.dart';

class AssetsDatasource implements IAssetsDatasource {
  const AssetsDatasource(
    this._apiBaseUrl,
    this._client,
  );

  final String _apiBaseUrl;
  final Client _client;

  @override
  AsyncResult<List<AssetModel>, Exception> fetchAssets(String companyId) async {
    try {
      final uri = Uri.https(_apiBaseUrl, '/companies/$companyId/assets');
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<AssetModel> assets = data
            .map((json) => AssetModel.fromMap(json as Map<String, dynamic>))
            .toList();

        return Success(assets);
      }

      return Failure(Exception(
          'Failed to fetch assets. Status code: ${response.statusCode}'));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<List<CompanyModel>, Exception> fetchCompanies() async {
    try {
      final uri = Uri.https(_apiBaseUrl, '/companies');
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<CompanyModel> companies = data
            .map((json) => CompanyModel.fromMap(json as Map<String, dynamic>))
            .toList();

        return Success(companies);
      }

      return Failure(Exception(
          'Failed to fetch companies. Status code: ${response.statusCode}'));
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  AsyncResult<List<LocationModel>, Exception> fetchLocations(
      String companyId) async {
    try {
      final uri = Uri.https(_apiBaseUrl, '/companies/$companyId/locations');
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<LocationModel> locations = data
            .map((json) => LocationModel.fromMap(json as Map<String, dynamic>))
            .toList();

        return Success(locations);
      }

      return Failure(Exception(
          'Failed to fetch locations. Status code: ${response.statusCode}'));
    } on Exception catch (e) {
      return Failure(e);
    }
  }
}
