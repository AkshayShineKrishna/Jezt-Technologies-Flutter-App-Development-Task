import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "refresh")
  String? refresh;
  @JsonKey(name: "access")
  String? access;
  @JsonKey(name: "detail")
  String? detail;
  LoginResponse({this.refresh, this.access, this.detail});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    refresh: json['refresh'] as String?,
    access: json['access'] as String?,
    detail: json['detail'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'refresh': refresh,
    'access': access,
    'detail': detail,
  };
}
