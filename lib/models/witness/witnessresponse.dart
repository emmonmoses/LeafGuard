// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/witness/witness.dart';

part 'witnessresponse.g.dart';

@JsonSerializable(explicitToJson: true)
class WitnessResponse {
  String? id;
  String? taskerId;
  List<Witness>? witnesses;

  WitnessResponse({
    this.id,
    this.taskerId,
    this.witnesses,
  });

  factory WitnessResponse.fromJson(Map<String, dynamic> json) =>
      _$WitnessResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WitnessResponseToJson(this);
}
