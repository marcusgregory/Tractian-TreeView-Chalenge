import 'tree_node.generic.dart';

class Tree<T> {
  const Tree({this.rootNodes = const []});

  final List<TreeNode<T>> rootNodes;
}
