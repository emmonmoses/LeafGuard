// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/phone/phone.dart';
import 'package:leafguard/models/provider/skillattachments.dart';

// Project imports:

part 'agent.g.dart';

@JsonSerializable(explicitToJson: true)
class Agent {
  String? id;
  Phone? phone;
  String? document;
  String? agentNumber;
  String? password;
  String? username;
  String? name;
  String? avatar;
  String? gender;
  String? email;
  String? address;
  List<Skillattachments>? attachments;
  int? status;
  String? description;
  String? role;
  DateTime? createdAt;

  Agent({
    this.id,
    this.phone,
    this.document,
    this.agentNumber,
    this.password,
    this.username,
    this.name,
    this.avatar,
    this.gender,
    this.email,
    this.address,
    this.attachments,
    this.status,
    this.description,
    this.role,
    this.createdAt,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => _$AgentFromJson(json);
  Map<String, dynamic> toJson() => _$AgentToJson(this);
}
