enum ComponentStatusEnum {
  operating,
  alert;

  factory ComponentStatusEnum.fromName(String? name) {
    if (name == null || name.isEmpty) {
      return ComponentStatusEnum.operating;
    }
    try {
      return ComponentStatusEnum.values
          .firstWhere((status) => status.name == name);
    } catch (e) {
      throw ArgumentError('Invalid ComponentStatusEnum name: $name');
    }
  }
}
