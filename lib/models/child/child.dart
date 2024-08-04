// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'child.g.dart';

@JsonSerializable(explicitToJson: true)
class Child {
  String? action;
  String? state;
  String? alias;
  String? name;

  Child({
    this.action,
    this.state,
    this.alias,
    this.name,
  });

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);
  Map<String, dynamic> toJson() => _$ChildToJson(this);

  @override
  toString() {
    String output = '{action:$action,state:$state,alias:$alias,name:$name}';
    return output;
  }
}
