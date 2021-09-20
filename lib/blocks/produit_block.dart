import 'package:flutter/material.dart';
import 'package:marchant_ambulant_gui/models/produit.dart';
import 'package:marchant_ambulant_gui/services/produit_service.dart';

class ProduitBlock extends ChangeNotifier {
  ProduitService _produitService;
  // Index

  ProduitBlock() {
    _produitService = ProduitService();
  }
  int _currentIndex = 1;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<List<Produit>> fetchProduits() async {
    return await this._produitService.fetchProduits();
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
  List<Produit> _produits = [];
  List<Produit> get produits => _produits;
  setProduits() {
    _produits = _produitService.produits;
    isLoggedIn = _produits == null ? false : true;
    notifyListeners();
  }

  getAllProduits() async {
    loading = true;
    loadingType = 'allProduits';
    await _produitService.getAllProduits();
    loading = false;
  }

  getProduitsParCategory(String idCategory) async {
    loading = true;
    loadingType = 'produitsParCategory';
    await _produitService.getProduitsParCategory(idCategory);
    loading = false;
  }

  Future<List<Produit>> searchProduit(String designation) async {
    return _produitService.searchProduit(designation);
  }

  sortList(Produit a, Produit b) {
    return null;
  }

  removeSort() {}
  replayLastSearch() {}
}
