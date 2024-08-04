// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:leafguard/models/question/question.dart';
import 'package:leafguard/models/question/question_create.dart';
import 'package:leafguard/models/question/question_search.dart';
import 'package:leafguard/models/question/question_update.dart';
import 'package:leafguard/services/question/questionService.dart';

class QuestionFactory with ChangeNotifier {
  List<Question> questions = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get questionList {
    return [...questions];
  }

  getQuestionId(id) {
    return questions.firstWhere((res) => res.id == id);
  }

  Future getQuestionById(questionId) async {
    QuestionService req = QuestionService();
    Question questionSearch = await req.getQuestionById(questionId);
    notifyListeners();
    return questionSearch;
  }

  Future<List<Question>?> getAllQuestions(page) async {
    QuestionService req = QuestionService();
    QuestionSearch? questionSearch = await req.getQuestions(page);
    if (questionSearch!.data != null) {
      questions = questionSearch.data!;
      isNextable = questionSearch.page! < questionSearch.pages!;
      isPrevious = (questionSearch.page! > 1);
      totalPages = questionSearch.pages!;
      notifyListeners();
      return questionSearch.data;
    } else {
      notifyListeners();
      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllQuestions(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllQuestions(--currentPage);
      notifyListeners();
    }
  }

  Future<QuestionCreate> createQuestion(
    name,
    status,
    // date
  ) async {
    final question = QuestionCreate(
      question_tag: name,
      question_status: status,
      // createdAt: date,
    );
    QuestionService requests = QuestionService();
    await requests.createQuestion(question);

    notifyListeners();
    return question;
  }

  Future<QuestionUpdate?> updateQuestion(updatedQuestion) async {
    QuestionService requests = QuestionService();
    QuestionUpdate? question = await requests.updateQuestion(updatedQuestion);

    notifyListeners();
    return question;
  }

  Future deleteQuestion(questionId) async {
    QuestionService requests = QuestionService();
    final result = await requests.deleteQuestion(questionId);

    notifyListeners();
    return result;
  }
}
