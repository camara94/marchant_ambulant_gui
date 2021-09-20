import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marchant_ambulant_gui/models/produit.dart';
import 'package:marchant_ambulant_gui/config.dart';

class ProduitService {
  List<Produit> produits = [];

  ProduitService() {
    fetchProduits();
  }

  Future<List<Produit>> fetchProduits() async {
    final response = await http.get(Uri.parse(BASE_URL + '/produits'));
    if (response.statusCode >= 200 && response.statusCode < 400) {
      this.produits = [];
      for (var i = 0; i < jsonDecode(response.body).length; i++) {
        Produit produit = new Produit(
            designation: jsonDecode(response.body)[i]['designation'],
            description: jsonDecode(response.body)[i]['description'],
            quantite: jsonDecode(response.body)[i]['quantite'],
            images: jsonDecode(response.body)[i]['images'].cast<String>(),
            tailles: jsonDecode(response.body)[i]['tailles'].cast<String>(),
            couleurs: jsonDecode(response.body)[i]['couleurs'].cast<String>(),
            adresse: jsonDecode(response.body)[i]['adresse'],
            prix: jsonDecode(response.body)[i]['prix'],
            category: jsonDecode(response.body)[i]['category']);
        this.produits.add(produit);
      }
      return this.produits;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  // Create storage
  Future<List<Produit>> getAllProduits() async {
    final response = await http.get(Uri.parse(BASE_URL + '/produits'));

    if (response.statusCode >= 200 && response.statusCode < 400) {
      // If the call to the server was successful, parse the JSON.
      // return User.fromJson(json.decode(response.body));
      for (var i = 0; i < jsonDecode(response.body).length; i++) {
        Produit produit = new Produit(
            designation: jsonDecode(response.body)[i]['designation'],
            description: jsonDecode(response.body)[i]['description'],
            quantite: jsonDecode(response.body)[i]['quantite'],
            images: jsonDecode(response.body)[i]['images'].cast<String>(),
            tailles: jsonDecode(response.body)[i]['tailles'].cast<String>(),
            couleurs: jsonDecode(response.body)[i]['couleurs'].cast<String>(),
            adresse: jsonDecode(response.body)[i]['adresse'],
            prix: jsonDecode(response.body)[i]['prix'],
            category: jsonDecode(response.body)[i]['category']);
        this.produits.add(produit);
      }

      setProduits(this.produits);
      return this.produits;
    } else {
      if (response.statusCode == 403) {
        Fluttertoast.showToast(
            msg: "Invalid Credentials",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
      // If that call was not successful, throw an error.
      // throw Exception(response.body);
      return jsonDecode(response.body);
    }
  }

  Future<List<Produit>> getProduitsParCategory(String idCategory) async {
    final response = await http
        .get(Uri.parse('$BASE_URL/produits/categories/' + idCategory));

    if (response.statusCode >= 200 && response.statusCode < 400) {
      // If the call to the server was successful, parse the JSON.
      // return User.fromJson(json.decode(response.body));
      var prds = jsonDecode(response.body);
      for (var i = 0; i < prds.length; i++) {
        this.produits.add(prds[i]);
      }
      setProduits(this.produits);
      return this.produits;
    } else {
      if (response.statusCode == 403) {
        Fluttertoast.showToast(
            msg: "Invalid Credentials",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
      }
      // If that call was not successful, throw an error.
      // throw Exception(response.body);
      return jsonDecode(response.body);
    }
  }

  Future<List<Produit>> searchProduit(String designation) async {
    final response = await http.get(
        Uri.parse(BASE_URL + '/produits/search?designation=' + designation));
    if (response.statusCode >= 200 && response.statusCode < 400) {
      this.produits = [];
      for (var i = 0; i < jsonDecode(response.body).length; i++) {
        Produit produit = new Produit(
            designation: jsonDecode(response.body)[i]['designation'],
            description: jsonDecode(response.body)[i]['description'],
            quantite: jsonDecode(response.body)[i]['quantite'],
            images: jsonDecode(response.body)[i]['images'].cast<String>(),
            tailles: jsonDecode(response.body)[i]['tailles'].cast<String>(),
            couleurs: jsonDecode(response.body)[i]['couleurs'].cast<String>(),
            adresse: jsonDecode(response.body)[i]['adresse'],
            prix: jsonDecode(response.body)[i]['prix'],
            category: jsonDecode(response.body)[i]['category']);
        this.produits.add(produit);
      }
      return this.produits;
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  setProduits(List<Produit> value) async {
    this.produits = value;
  }

  getProduits() async {
    return this.produits;
  }
}
