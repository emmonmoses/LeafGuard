// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/witness/witness.dart';

part 'witness_update.g.dart';

@JsonSerializable(explicitToJson: true)
class WitnessUpdate {
  String? id;
  String? taskerId;
  List<Witness> taskerWitnesses;

  WitnessUpdate({
    required this.id,
    this.taskerId,
    required this.taskerWitnesses,
  });

  factory WitnessUpdate.fromJson(Map<String, dynamic> json) =>
      _$WitnessUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$WitnessUpdateToJson(this);
}
