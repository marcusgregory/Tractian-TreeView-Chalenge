import 'package:flutter/material.dart';

import '../../common/generics/tree_node.generic.dart';
import '../../domain/entities/filterable.entity.dart';
import 'tree_item.widget.dart';

class AssetTreeNodeWidget extends StatelessWidget {
  const AssetTreeNodeWidget({
    super.key,
    required this.treeNode,
  });

  final TreeNode<FilterableEntity> treeNode;

  @override
  Widget build(BuildContext context) {
    // Verify if this node is not filtered
    if (!treeNode.value.isActive) {
      return const SizedBox.shrink();
    }

    final nodeWidget = ItemTreeWidget(data: treeNode.value.entity);

    if (treeNode.children.any((child) => child.value.isActive)) {
      List<Widget> children = [];
      for (final child in treeNode.children) {
        children.add(AssetTreeNodeWidget(treeNode: child));
      }
      return ExpansionTile(
        controlAffinity: ListTileControlAffinity.leading,
        shape: const Border(),
        title: nodeWidget,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 11.0),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Color(0xFFDCDCDC)),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ],
      );
    }

    return ListTile(
      title: nodeWidget,
    );
  }
}
