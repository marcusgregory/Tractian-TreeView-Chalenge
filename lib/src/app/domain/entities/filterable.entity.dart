class FilterableEntity<T> {
  FilterableEntity(
    this.entity, {
    this.isActive = true,
  });

  final T entity;
  bool isActive;

  void updateFilterStatus(bool status) {
    this.isActive = status;
  }
}
