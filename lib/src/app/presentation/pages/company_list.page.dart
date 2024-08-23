import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treeview_challenge/src/app/presentation/pages/asset_tree.page.dart';

import '../../shared/constants/constants.dart';
import '../controllers/company_list.controller.dart';
import '../widgets/company_list.widget.dart';

class CompanyListPage extends GetView<CompanyListController> {
  const CompanyListPage({super.key});

  static const String routePath = '/companies';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPng,
          height: 20.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: controller.obx(
          (companies) => CompanyListWidget(
            companies: companies!,
            onTapCompany: _navigateToAssetTree,
          ),
          onError: (error) => Center(
            child: Column(
              children: [
                Text('An error occurred: $error'),
                ElevatedButton(
                  onPressed: controller.retry,
                  child: const Text('Try again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToAssetTree(String companyId) {
    Get.toNamed('${AssetTreePage.routeBase}/$companyId');
  }
}
