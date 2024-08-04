// Package imports:
// import 'package:json_annotation/json_annotation.dart';

// part 'admin_change_password.g.dart';

// @JsonSerializable(explicitToJson: true)
class ChangeAdministratorPassword {
  String? administratorId;
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  ChangeAdministratorPassword({
    this.administratorId,
    this.oldPassword,
    this.newPassword,
    this.confirmPassword,
  });

Map<String, dynamic> toJson() {
    return {
      'administratorId': administratorId,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
  }
  
  // factory ChangeAdministratorPassword.fromJson(Map<String, dynamic> json) =>
  //     _$ChangeAdministratorPasswordFromJson(json);
  // Map<String, dynamic> toJson() => _$ChangeAdministratorPasswordToJson(this);
}
