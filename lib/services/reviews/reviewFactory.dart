// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:leafguard/models/reviews/review_create.dart';
import 'package:leafguard/models/reviews/review_search.dart';
import 'package:leafguard/models/reviews/reviews.dart';

// Project imports:
import 'package:leafguard/services/reviews/reviewService.dart';

class ReviewFactory with ChangeNotifier {
  List<Reviews> reviews = [];
  bool isNextable = false;
  bool isPrevious = false;
  int currentPage = 1;
  int totalPages = 0;

  get reviewList {
    return [...reviews];
  }

  getReviewId(id) {
    return reviews.firstWhere((res) => res.id == id);
  }

  Future getReviewById(companyId) async {
    ReviewService req = ReviewService();
    ReviewSearch reviewSearch = await req.getReviewById(companyId);
    notifyListeners();
    return reviewSearch;
  }

  Future<List<Reviews>?> getAllReviews(page) async {
    ReviewService req = ReviewService();
    ReviewSearch? reviewSearch = await req.getReviews(page);
    if (reviewSearch!.data != null) {
      reviews = reviewSearch.data!;
      isNextable = reviewSearch.page! < reviewSearch.pages!;
      isPrevious = (reviewSearch.page! > 1);
      totalPages = reviewSearch.pages!;
      notifyListeners();
      return reviewSearch.data;
    } else {
      notifyListeners();
      return null;
    }
  }

  Future<void> goNext() async {
    if (isNextable) {
      await getAllReviews(++currentPage);
      notifyListeners();
    }
  }

  Future<void> goPrevious() async {
    if (isPrevious) {
      await getAllReviews(--currentPage);
      notifyListeners();
    }
  }

  Future<ReviewCreate> createReview(
    usertype,
    taskid,
    userid,
    taskerid,
    rating,
    comments,
    reviews,
    status,
  ) async {
    final review = ReviewCreate(
      usertype: usertype,
      taskid: taskid,
      userid: userid,
      taskerid: taskerid,
      rating: rating,
      comments: comments,
      review: reviews,
      status: status,
    );

    ReviewService requests = ReviewService();
    await requests.createReview(review);

    notifyListeners();
    return review;
  }

  Future<Reviews?> updateReview(updatedReview) async {
    ReviewService requests = ReviewService();
    Reviews? review = await requests.updateReview(updatedReview);

    notifyListeners();
    return review;
  }

  Future deleteReview(userId) async {
    ReviewService requests = ReviewService();
    final result = await requests.deleteReview(userId);

    notifyListeners();
    return result;
  }
}
