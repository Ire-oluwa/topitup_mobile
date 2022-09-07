class AvailableServiceModel {
  int? id;
  String? name;
  String? systemName;
  String? defaultPrice;
  String? description;
  String? logo;

  AvailableServiceModel({
    this.id,
    this.name,
    this.systemName,
    this.defaultPrice,
    this.description,
    this.logo,
  });

  static AvailableServiceModel fromJson(json) => AvailableServiceModel(
        id: json['available_service_id'] as int?,
        name: json['available_service_name'] as String?,
        systemName: json['available_service_system_name'] as String?,
        defaultPrice: json['available_service_default_price'] as String?,
        description: json['available_service_description'] as String?,
        logo: json['available_service_logo'] as String?,
      );
}
