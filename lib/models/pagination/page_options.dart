// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'page_options.g.dart';

@JsonSerializable(explicitToJson: true)
class Paginator {
  int status;
  int? page;
  int? pages;
  int? pageSize;
  int? rows;
  Paginator({
    this.status = 1,
    this.page,
    this.pages,
    this.pageSize,
    this.rows,
  });

  factory Paginator.fromJson(Map<String, dynamic> json) =>
      _$PaginatorFromJson(json);
  Map<String, dynamic> toJson() => _$PaginatorToJson(this);
}
