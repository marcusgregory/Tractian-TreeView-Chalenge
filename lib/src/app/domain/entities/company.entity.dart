class CompanyEntity {
  final String id;
  final String name;

  const CompanyEntity({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompanyEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CompanyEntity(id: $id, name: $name)';
  }
}
