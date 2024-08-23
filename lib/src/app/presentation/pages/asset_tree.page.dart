import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:treeview_challenge/src/app/presentation/icons/tractian_icons_icons.dart';

import '../controllers/asset_tree.controller.dart';
import '../widgets/asset_tree.widget.dart';
import '../widgets/filter_option.widget.dart';

class AssetTreePage extends GetView<AssetTreeController> {
  const AssetTreePage({super.key});

  static const String routeBase = '/assets';
  static const String companyIdParam = 'companyId';
  static const String routePath = '$routeBase/:$companyIdParam';

  @override
  Widget build(BuildContext context) {
    final companyId = Get.parameters[companyIdParam]!;

    controller.loadData(companyId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
        leading: Visibility(
          visible: Navigator.of(context).canPop(),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller.searchController,
                  textInputAction: TextInputAction.search,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: controller.onSearchTextChanged,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color(0xFFEAEFF3),
                    filled: true,
                    hintText: 'Search asset or location',
                    prefixIcon: Icon(Icons.search),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 8.0),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: FilterOptionWidget(
                          onTapCallback: controller.setEnergySensorsFilter,
                          isSelected: controller.energySensorsFilter.value,
                          icon: Icons.bolt,
                          textLabel: 'Energy Sensor',
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: FilterOptionWidget(
                          onTapCallback: controller.setCriticalStatusFilter,
                          isSelected: controller.criticalStatusFilter.value,
                          icon: TractianIcons.info,
                          textLabel: 'Critical',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: controller.obx(
              (tree) => AssetTreeWidget(tree: tree!),
              onError: (error) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
