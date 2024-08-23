import 'dart:convert';

class CompanyModel {
  const CompanyModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompanyModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
