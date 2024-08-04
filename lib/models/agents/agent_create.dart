// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/phone/phone.dart';
// import 'package:leafguard/models/serovider/skillattachments.dart';

part 'agent_create.g.dart';

@JsonSerializable(explicitToJson: true)
class AgentCreate {
  Phone? phone;
  // String? adminNumber;
  String? username;
  String? document;
  String? name;
  String? avatar;
  String? gender;
  String? email;
  String? password;
  String? address;
  // List<Skillattachments>? attachments;
  int? status;
  String? description;
  // String? role;

  AgentCreate({
    this.phone,
    // this.adminNumber,
    this.username,
    this.document,
    this.name,
    this.avatar,
    this.gender,
    this.email,
    this.password,
    this.address,
    // this.attachments,
    this.status,
    this.description,
    // this.role,
  });

  factory AgentCreate.fromJson(Map<String, dynamic> json) =>
      _$AgentCreateFromJson(json);
  Map<String, dynamic> toJson() => _$AgentCreateToJson(this);
}
