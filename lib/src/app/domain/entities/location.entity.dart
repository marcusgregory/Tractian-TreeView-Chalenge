class LocationEntity {
  final String id;
  final String name;
  final String? parentId;

  const LocationEntity({
    required this.id,
    required this.name,
    this.parentId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationEntity &&
        other.id == id &&
        other.name == name &&
        other.parentId == parentId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ (parentId?.hashCode ?? 0);
  }

  @override
  String toString() {
    return 'LocationEntity(id: $id, name: $name, parentId: ${parentId ?? 'none'})';
  }
}
