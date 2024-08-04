// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/witness/witness.dart';

part 'witness_create.g.dart';

@JsonSerializable(explicitToJson: true)
class WitnessCreate {
  String? taskerId;
  List<Witness> taskerWitnesses;

  WitnessCreate({
    this.taskerId,
    required this.taskerWitnesses,
  });

  factory WitnessCreate.fromJson(Map<String, dynamic> json) =>
      _$WitnessCreateFromJson(json);
  Map<String, dynamic> toJson() => _$WitnessCreateToJson(this);
}
