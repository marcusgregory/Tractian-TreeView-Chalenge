import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/generics/tree.generic.dart';
import '../../shared/generics/tree_node.generic.dart';
import '../../domain/entities/asset.entity.dart';
import '../../domain/entities/filterable.entity.dart';
import '../../domain/entities/location.entity.dart';
import '../../domain/enums/component_sensor_type.enum.dart';
import '../../domain/enums/component_status.enum.dart';
import '../../domain/repositories/i_asset.repository.dart';

class AssetTreeController extends GetxController
    with StateMixin<Tree<FilterableEntity>> {
  AssetTreeController(this._repository);

  final IAssetRepository _repository;

  final searchController = TextEditingController();

  final energySensorsFilter = false.obs;
  final criticalStatusFilter = false.obs;

  Tree<FilterableEntity>? _assetTree;

  Timer? _debounce;

  Future<void> loadData(String companyId) async {
    change(null, status: RxStatus.loading());

    searchController.text = '';
    energySensorsFilter.value = false;
    criticalStatusFilter.value = false;

    final locationResult = await _repository.fetchLocations(companyId);

    locationResult.fold(
      (locations) async {
        final assetResult = await _repository.fetchAssets(companyId);

        assetResult.fold(
            (assets) => _createTree(locations, assets), _handleError);
      },
      _handleError,
    );
  }

  void _handleError(Exception e) {
    change(null, status: RxStatus.error(e.toString()));
  }

  void _createTree(List<LocationEntity> locations, List<AssetEntity> assets) {
    final nodesMap = <String, TreeNode<FilterableEntity>>{};
    final rootNodeList = <TreeNode<FilterableEntity>>[];

    for (var location in locations) {
      nodesMap[location.id] =
          TreeNode<FilterableEntity>(FilterableEntity(location));
    }

    for (var asset in assets) {
      nodesMap[asset.id] = TreeNode<FilterableEntity>(FilterableEntity(asset));
    }

    for (var location in locations) {
      if (nodesMap.containsKey(location.parentId)) {
        nodesMap[location.parentId]!.child(nodesMap[location.id]!);
      } else {
        rootNodeList.add(nodesMap[location.id]!);
      }
    }

    for (var asset in assets) {
      if (nodesMap.containsKey(asset.locationId)) {
        nodesMap[asset.locationId]!.child(nodesMap[asset.id]!);
      } else if (nodesMap.containsKey(asset.parentId)) {
        nodesMap[asset.parentId]!.child(nodesMap[asset.id]!);
      } else {
        rootNodeList.add(nodesMap[asset.id]!);
      }
    }

    _assetTree = Tree(rootNodes: rootNodeList);

    _orderNodes(_assetTree!);

    change(_assetTree, status: RxStatus.success());
  }

  void _orderNodes(Tree tree) {
    tree.rootNodes.sort(_sortNodes);

    for (var node in tree.rootNodes) {
      final queue = Queue<TreeNode>.from([node]);

      while (queue.isNotEmpty) {
        final current = queue.removeFirst();

        current.children.sort(_sortNodes);

        queue.addAll(current.children);
      }
    }
  }

  int _sortNodes(TreeNode a, TreeNode b) {
    final childrenComparison = b.children.length.compareTo(a.children.length);

    if (childrenComparison == 0) {
      final aWeight = _getNodeWeight(a);
      final bWeight = _getNodeWeight(b);

      return aWeight.compareTo(bWeight);
    }

    return childrenComparison;
  }

  int _getNodeWeight(TreeNode node) {
    if (node.value is LocationEntity) {
      return 0;
    } else if (node.value is AssetEntity) {
      if ((node.value as AssetEntity).sensorType == null) {
        return 1;
      }
    }
    return 2;
  }

  void onSearchTextChanged(String _) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
      _applyFilters,
    );
  }

  void setEnergySensorsFilter(bool value) {
    energySensorsFilter.value = value;
    _applyFilters();
  }

  void setCriticalStatusFilter(bool value) {
    criticalStatusFilter.value = value;
    _applyFilters();
  }

  Future<void> _applyFilters() async {
    change(null, status: RxStatus.loading());

    for (var root in _assetTree!.rootNodes) {
      _traverseAndFilter(root);
    }

    change(_assetTree, status: RxStatus.success());
  }

  bool _traverseAndFilter(TreeNode<FilterableEntity> node) {
    var shouldFilter = false;

    for (var child in node.children) {
      shouldFilter |= _traverseAndFilter(child);
    }

    if (!shouldFilter) {
      shouldFilter = _shouldFilterNode(node);
    }

    node.value.updateFilterStatus(shouldFilter);

    return shouldFilter;
  }

  bool _shouldFilterNode(TreeNode<FilterableEntity> node) {
    final nodeValue = node.value.entity;
    final query = searchController.text;

    var matchesSearchText = true;
    var matchesSensorType = true;
    var matchesStatus = true;

    if (query.isNotEmpty) {
      matchesSearchText =
          nodeValue.toString().toLowerCase().contains(query.toLowerCase());
    }

    if (energySensorsFilter.value) {
      matchesSensorType = (nodeValue is AssetEntity) &&
          nodeValue.sensorType == ComponentSensorTypeEnum.energy;
    }

    if (criticalStatusFilter.value) {
      matchesStatus = (nodeValue is AssetEntity) &&
          nodeValue.status == ComponentStatusEnum.alert;
    }

    return matchesSearchText && matchesSensorType && matchesStatus;
  }
}
