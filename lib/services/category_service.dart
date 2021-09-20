import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:marchant_ambulant_gui/models/category.dart';
import 'package:marchant_ambulant_gui/config.dart';

class CategoryService {
  List<Category> categories = [];

  CategoryService() {
    fetchCategroies();
  }

  Future<List<Category>> fetchCategroies() async {
    final response = await http.get(Uri.parse(BASE_URL + '/categories'));
    if (response.statusCode >= 200 && response.statusCode < 400) {
      this.categories = [];
      for (var i = 0; i < jsonDecode(response.body).length; i++) {
        Category category = new Category(
          id: jsonDecode(response.body)[i]['_id'],
          nom: jsonDecode(response.body)[i]['nom'],
          description: jsonDecode(response.body)[i]['description'],
          image: jsonDecode(response.body)[i]['image'],
          mobIcon: jsonDecode(response.body)[i]['mobIcon'],
          webIcon: jsonDecode(response.body)[i]['webIcon'],
        );
        this.categories.add(category);
      }
      print(this.categories);
      return this.categories;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Create storage
  Future<List<Category>> getAllCategories() async {
    final response = await http.get(Uri.parse(BASE_URL + '/categories'));
    if (response.statusCode >= 200 && response.statusCode < 400) {
      this.categories = [];
      for (var i = 0; i < jsonDecode(response.body).length; i++) {
        Category category = new Category(
          id: jsonDecode(response.body)[i]['_id'],
          nom: jsonDecode(response.body)[i]['nom'],
          description: jsonDecode(response.body)[i]['description'],
          image: jsonDecode(response.body)[i]['image'],
          mobIcon: jsonDecode(response.body)[i]['mobIcon'],
          webIcon: jsonDecode(response.body)[i]['webIcon'],
        );
        this.categories.add(category);
      }
      print(this.categories);
      return this.categories;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  setCategories(List<Category> value) async {
    this.categories = value;
  }

  getCategories() async {
    return this.categories;
  }
}
