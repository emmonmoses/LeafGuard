// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'cancel_Action.g.dart';

@JsonSerializable(explicitToJson: true)
class CancelAction {
  String? person;
  String? personType;
  String? cancelReason;
  DateTime? cancelDate;

  CancelAction({this.person, this.personType, this.cancelReason});

  factory CancelAction.fromJson(Map<String, dynamic> json) =>
      _$CancelActionFromJson(json);
  Map<String, dynamic> toJson() => _$CancelActionToJson(this);
}
