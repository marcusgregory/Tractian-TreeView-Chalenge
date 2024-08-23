import 'package:get/get.dart';

import '../../domain/entities/company.entity.dart';
import '../../domain/repositories/i_asset.repository.dart';

class CompanyListController extends GetxController
    with StateMixin<List<CompanyEntity>> {
  CompanyListController(this._repository);

  final IAssetRepository _repository;

  @override
  void onInit() {
    _fetchCompanies();

    super.onInit();
  }

  Future<void> _fetchCompanies() async {
    final result = await _repository.fetchCompanies();

    result.fold(
      (companies) {
        change(companies, status: RxStatus.success());
      },
      (error) {
        change(null, status: RxStatus.error(error.toString()));
      },
    );
  }

  void retry() {
    _fetchCompanies();
  }
}
