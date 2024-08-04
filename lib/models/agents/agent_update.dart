// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/phone/phone.dart';
import 'package:leafguard/models/provider/skillattachments.dart';

part 'agent_update.g.dart';

@JsonSerializable(explicitToJson: true)
class AgentUpdate {
  String id;
  Phone? phone;
  String? agentNumber;
  String? username;
  String? name;
  String? avatar;
  String? document;
  String? gender;
  String? email;
  String? address;
  List<Skillattachments>? attachments;
  int? status;
  String? description;
  String? role;

  AgentUpdate({
    required this.id,
    this.phone,
    this.agentNumber,
    this.username,
    this.name,
    this.avatar,
    this.document,
    this.gender,
    this.email,
    this.address,
    this.attachments,
    this.status,
    this.description,
    this.role,
  });

  factory AgentUpdate.fromJson(Map<String, dynamic> json) =>
      _$AgentUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$AgentUpdateToJson(this);
}
