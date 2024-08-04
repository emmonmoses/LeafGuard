// ignore_for_file: file_names

// Flutter imports:

import 'package:flutter/material.dart';
import 'package:leafguard/models/agents/agent.dart';
import 'package:leafguard/models/agents/agent_create.dart';
import 'package:leafguard/models/agents/agent_search.dart';
import 'package:leafguard/models/agents/agent_update.dart';
import 'package:leafguard/services/agent/agentService.dart';

class AgentFactory with ChangeNotifier {
  List<Agent> agents = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get agentList {
    return [...agents];
  }

  getAgentId(id) {
    return agents.firstWhere((res) => res.id == id);
  }

  Future getAgentById(agentId) async {
    AgentService req = AgentService();
    Agent agentSearch = await req.getAgentById(agentId);

    notifyListeners();
    return agentSearch;
  }

  Future<List<Agent>?> getAgents(page) async {
    AgentService req = AgentService();
    AgentSearch? agentSearch = await req.getAgents(page);

    if (agentSearch!.data != null) {
      agents = agentSearch.data!;
      isNextable = agentSearch.page! < agentSearch.pages!;
      isPrevious = (agentSearch.page! > 1);
      totalPages = agentSearch.pages!;
      notifyListeners();
      return agentSearch.data;
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAgents(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAgents(--currentPage);
      notifyListeners();
    }
  }

  Future<AgentCreate> createAgent(
    phone,
    // adminNumber,
    username,
    name,
    avatar,
    document,
    gender,
    email,
    password,
    address,
    // attachments,
    status,
    description,
  ) async {
    final agent = AgentCreate(
      phone: phone,
      // adminNumber: adminNumber,
      username: username,
      name: name,
      avatar: avatar,
      document: document,
      gender: gender,
      email: email,
      password: password,
      address: address,
      // attachments: attachments,
      status: status,
      description: description,
    );

    AgentService requests = AgentService();
    await requests.createAgent(agent);
    return agent;
  }

  Future<AgentUpdate?> updateAgent(updatedAgent) async {
    AgentService requests = AgentService();
    AgentUpdate? agent = await requests.updateAgent(updatedAgent);

    notifyListeners();
    return agent;
  }

  Future deleteAgent(taxId) async {
    AgentService requests = AgentService();
    final result = await requests.deleteAgent(taxId);

    notifyListeners();
    return result;
  }

  Future<AgentUpdate?> verifyAgent(agentId) async {
    AgentService requests = AgentService();
    AgentUpdate? result = await requests.verifyAgent(agentId);

    notifyListeners();
    return result;
  }
}
