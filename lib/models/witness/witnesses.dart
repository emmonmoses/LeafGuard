// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/provider/provider.dart';
import 'package:leafguard/models/witness/witness.dart';

part 'witnesses.g.dart';

@JsonSerializable(explicitToJson: true)
class Witnesses {
  String? id;
  String? taskerId;
  List<Witness>? witnesses;
  ServiceProvider? tasker;

  Witnesses({
    this.id,
    this.taskerId,
    this.witnesses,
    this.tasker,
  });

  factory Witnesses.fromJson(Map<String, dynamic> json) =>
      _$WitnessesFromJson(json);
  Map<String, dynamic> toJson() => _$WitnessesToJson(this);
}
