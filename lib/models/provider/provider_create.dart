// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/dob/dob.dart';
import 'package:leafguard/models/phone/phone.dart';
import 'package:leafguard/models/profileDetails/profile.dart';
import 'package:leafguard/models/provider/skillattachments.dart';

part 'provider_create.g.dart';

@JsonSerializable(explicitToJson: true)
class ProviderCreate {
  String? name;
  String? username;
  String? gender;
  BirthDate? birthdate;
  String? email;
  Phone? phone;
  String? avatar;
  String? password;
  List<ProfileDetails>? profile_details;
  String? document;
  String? documentType;
  // List<ServiceProviderSkills>? taskerskills;
  // List<WorkingDay>? working_days;
  String? availability_address;
  String? experienceId;
  int? status;
  int? taskerStatus;
  List<Skillattachments>? skillattachments;
  List<String>? categoryId;
  String? createdBy;
  // int? radiusby;
  // Location? location;

  ProviderCreate({
    this.username,
    this.gender,
    this.birthdate,
    this.email,
    this.phone,
    this.avatar,
    this.password,
    this.profile_details,
    this.name,
    this.experienceId,
    this.status,
    this.skillattachments,
    this.taskerStatus,
    this.document,
    this.documentType,
    // this.taskerskills,
    // this.working_days,
    this.availability_address,
    this.categoryId,
    this.createdBy,
    // this.radiusby,
    // this.location,
  });

  factory ProviderCreate.fromJson(Map<String, dynamic> json) =>
      _$ProviderCreateFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderCreateToJson(this);
}
