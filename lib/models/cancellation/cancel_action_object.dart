import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/cancellation/cancel_Action.dart';
part 'cancel_action_object.g.dart';

@JsonSerializable(explicitToJson: true)
class CancelActionObject {
  CancelAction? cancelAction;
  CancelActionObject({
    this.cancelAction,
  });

  factory CancelActionObject.fromJson(Map<String, dynamic> json) =>
      _$CancelActionObjectFromJson(json);
  Map<String, dynamic> toJson() => _$CancelActionObjectToJson(this);
}
