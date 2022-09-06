class SubServiceModel {
  int? id;
  String? name;
  String? code;

  SubServiceModel({
    this.id,
    this.name,
    this.code,
  });

  static SubServiceModel fromJson(json) => SubServiceModel(
        id: json['sub_service_id'] as int?,
        name: json['sub_service_name'] as String?,
        code: json['sub_service_code'] as String?,
      );
}
