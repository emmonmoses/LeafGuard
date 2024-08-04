// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ErrorResponse {
  bool? status;
  String? message;
  String? details;

  ErrorResponse({this.status,this.message,this.details});
  
  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  @override
  @override
  String toString() {
    String output = '{status:$status, message: $message, details: $details }';
    return output;
  }
}
