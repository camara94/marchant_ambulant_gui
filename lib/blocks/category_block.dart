import 'package:flutter/material.dart';
import 'package:marchant_ambulant_gui/models/category.dart';
import 'package:marchant_ambulant_gui/services/category_service.dart';

class CategoryBlock extends ChangeNotifier {
  CategoryService _categoryService;
  // Index

  CategoryBlock() {
    _categoryService = CategoryService();
  }
  int _currentIndex = 1;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<List<Category>> fetchCategories() {
    return this._categoryService.getAllCategories();
  }

  // Loading
  bool _loading = false;
  String _loadingType;
  bool get loading => _loading;
  String get loadingType => _loadingType;
  set loading(bool loadingState) {
    _loading = loadingState;
    notifyListeners();
  }

  set loadingType(String loadingType) {
    _loadingType = loadingType;
    notifyListeners();
  }

  // Loading
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool isUserExist) {
    _isLoggedIn = isUserExist;
    notifyListeners();
  }

  // user
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  setCategories() {
    _categories = _categoryService.categories;
    isLoggedIn = _categories == null ? false : true;
    notifyListeners();
  }

  getAllCategories() async {
    loading = true;
    loadingType = 'allCategories';
    await _categoryService.getAllCategories();
    loading = false;
  }
}
