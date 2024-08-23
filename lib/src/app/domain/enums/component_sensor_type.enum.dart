enum ComponentSensorTypeEnum {
  vibration,
  energy;

  factory ComponentSensorTypeEnum.fromName(String name) {
    try {
      return ComponentSensorTypeEnum.values
          .firstWhere((type) => type.name == name);
    } catch (e) {
      throw ArgumentError('Invalid ComponentSensorTypeEnum name: $name');
    }
  }
}
