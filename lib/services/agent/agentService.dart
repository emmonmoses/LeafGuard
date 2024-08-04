// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:leafguard/models/agents/agent.dart';
import 'package:leafguard/models/agents/agent_create.dart';
import 'package:leafguard/models/agents/agent_search.dart';
import 'package:leafguard/models/agents/agent_update.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;

class AgentService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/agents';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<AgentSearch?> getAgents(page) async {
    try {
      accessToken = await sharedPref.read(key);
      var searchUrl = "$baseUrl?page=$page";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = AgentSearch.fromJson(map);

        return result;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<Agent> getAgentById(agentId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$agentId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = Agent.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<AgentCreate?> createAgent(AgentCreate agent) async {
    try {
      var content = jsonEncode(agent.toJson());
      accessToken = await sharedPref.read(key);
      searchUrl = baseUrl;

      http.Response response = await http.post(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 201) {
        return agent;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<AgentUpdate?> updateAgent(AgentUpdate updatedAgent) async {
    try {
      var content = jsonEncode(updatedAgent.toJson());
      accessToken = await sharedPref.read(key);
      searchUrl = baseUrl;

      http.Response response = await http.patch(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        return updatedAgent;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteAgent(agentId) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$baseUrl/$agentId";

      var response = await http.delete(
        Uri.parse(searchUrl),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      return response.statusCode;
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<AgentUpdate?> verifyAgent(agentId) async {
    accessToken = await sharedPref.read(key);

    searchUrl = '$baseUrl/verify/agent/$agentId';

    var response = await http.patch(
      Uri.parse(searchUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      try {
        var agentUpdate = AgentUpdate.fromJson(json.decode(response.body));
        return agentUpdate;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
