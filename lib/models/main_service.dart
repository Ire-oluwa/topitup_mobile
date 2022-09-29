class MainServiceModel {
  int? serviceId;
  String? serviceName;
  String? serviceCode;
  String? mainServiceLogo;
  String? fullLogo;
  String? mainServiceDescription;

  MainServiceModel({
    this.serviceId,
    this.serviceName,
    this.serviceCode,
    this.mainServiceLogo,
    this.fullLogo,
    this.mainServiceDescription,
  });

  static MainServiceModel fromJson(json) => MainServiceModel(
        serviceId: json['service_id'] as int?,
        serviceName: json['service_name'] as String?,
        serviceCode: json['service_code'] as String?,
        mainServiceLogo: json['main_service_logo'] as String?,
        fullLogo: json['full_logo'] as String?,
        mainServiceDescription: json['main_service_description'] as String?,
      );
}
