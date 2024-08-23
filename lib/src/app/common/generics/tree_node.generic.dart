class TreeNode<T> {
  TreeNode(this.value) : children = <TreeNode<T>>[];

  final T value;
  final List<TreeNode<T>> children;

  void child(TreeNode<T> node) {
    children.add(node);
  }
}
