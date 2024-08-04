// ignore_for_file: overridden_fields, annotate_overrides
// Project imports:
import 'package:leafguard/models/agents/agent.dart';
import 'package:leafguard/models/pagination/page_options.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'agent_search.g.dart';

@JsonSerializable(explicitToJson: true)
class AgentSearch extends Paginator {
  List<Agent>? data;
  AgentSearch({
    int status = 1,
    int? page,
    int? pages,
    int? pageSize,
    int? rows,
    this.data,
  }) : super(
          status: status,
          page: page,
          pages: pages,
          pageSize: pageSize,
          rows: rows,
        );

  factory AgentSearch.fromJson(Map<String, dynamic> json) =>
      _$AgentSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AgentSearchToJson(this);
}
