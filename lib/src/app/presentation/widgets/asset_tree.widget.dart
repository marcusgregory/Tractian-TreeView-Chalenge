import 'package:flutter/material.dart';

import '../../shared/generics/tree.generic.dart';
import '../../domain/entities/filterable.entity.dart';
import 'asset_tree_node.widget.dart';

class AssetTreeWidget extends StatelessWidget {
  const AssetTreeWidget({
    super.key,
    required this.tree,
  });

  final Tree<FilterableEntity> tree;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
          itemCount: tree.rootNodes.length,
          itemBuilder: (context, index) {
            return AssetTreeNodeWidget(
              treeNode: tree.rootNodes[index],
            );
          }),
    );
  }
}
