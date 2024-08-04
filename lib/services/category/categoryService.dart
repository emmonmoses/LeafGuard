// ignore_for_file: prefer_typing_uninitialized_variables, file_names

// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

// Project imports:
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/category/category_create.dart';
import 'package:leafguard/models/category/category_search.dart';
import 'package:leafguard/models/category/category_update.dart';
import 'package:leafguard/models/uploadCategory/upload.dart';
import 'package:leafguard/services/main_api_endpoint.dart';
import 'package:leafguard/services/sharedpref_service.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:leafguard/services/toaster_service.dart';
import 'package:universal_html/html.dart';

class CategoryService {
  var searchUrl;
  final baseUrl = '${ApiEndPoint.endpoint}/newcategories';
  final logoUrl = '${ApiEndPoint.endpoint}/newcategories/image';
  final uploadUrl = '${ApiEndPoint.endpoint}/newcategories/upload';
  var accessToken;
  String key = 'storedToken';
  SharedPref sharedPref = SharedPref();

  Future<CategorySearch?> getCategories(page) async {
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
        var result = CategorySearch.fromJson(map);

        return result;
      } else {
        // throw Exception('error loading object');
        return null;
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<CategorySearch> getCategoriesWithMorePageSize(page) async {
    try {
      accessToken = await sharedPref.read(key);

      var searchUrl = "$baseUrl?page=$page&pageSize=200";

      http.Response response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = CategorySearch.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<Category> getCategoryById(categoryId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$categoryId";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = Category.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<CategoryCreate?> createCategory(CategoryCreate category) async {
    try {
      var content = jsonEncode(category.toJson());
      accessToken = await sharedPref.read(key);
      searchUrl = baseUrl;

      var response = await http.post(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 201) {
        return category;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<Category?> updateCategory(CategoryUpdate updatedCategory) async {
    try {
      var content = jsonEncode(updatedCategory.toJson());
      accessToken = await sharedPref.read(key);
      searchUrl = baseUrl;

      var response = await http.patch(
        Uri.parse(searchUrl),
        body: content,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future deleteCategory(categoryId) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/$categoryId";

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

  Future<Uint8List> getCategoryLogo(imageName) async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = "$logoUrl/$imageName";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Error loading image');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }

  Future<dynamic> uploadImage() async {
    try {
      accessToken = await sharedPref.read(key);
      searchUrl = uploadUrl;

      final input = FileUploadInputElement();
      input.accept =
          'image/*'; // Set accepted file types (in this case, images)
      input.click(); // Trigger the file picker dialog
      await input.onChange.first; // Wait for the user to select a file

      final file = input.files!.first;
      final formData = FormData();

      formData.appendBlob('image', file);

      var response = await http.post(
        Uri.parse(searchUrl),
        body: formData,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final upload = UploadCategory.fromJson(responseData);

        return upload.image;
      } else {
        toastError('Error uploading image');
        throw Exception('Error uploading image');
      }
    } catch (e) {
      toastError(e);
      throw Exception('Error during API call: $e');
    }
  }

  Future<CategorySearch> getCategoriesByMainCategoryId(
      mainCategoryId, page) async {
    try {
      accessToken = await sharedPref.read(key);

      searchUrl = "$baseUrl/maincategory/$mainCategoryId?page=$page";

      var response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        var result = CategorySearch.fromJson(map);

        return result;
      } else {
        throw Exception('error loading object');
      }
    } catch (e) {
      throw Exception('Error during API call: $e');
    }
  }
}
