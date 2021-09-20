import 'package:marchant_ambulant_gui/models/user.dart';

class Produit {
  String id;
  String designation;
  List<dynamic> couleurs;
  List<dynamic> tailles;
  String description;
  int quantite;
  bool disponible;
  List<dynamic> images;
  int prix;
  User user;
  String category;
  String adresse;
  Produit(
      {this.id,
      this.designation,
      this.couleurs,
      this.tailles,
      this.description,
      this.quantite,
      this.disponible,
      this.images,
      this.user,
      this.category,
      this.adresse,
      this.prix});
  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
        id: json['id'],
        designation: json['designation'],
        couleurs: json['couleurs'],
        tailles: json['tailles'],
        description: json['description'],
        quantite: json['quantite'],
        disponible: json['disponible'],
        images: json['images'],
        user: User.fromJson(json['user']),
        category: json['category'],
        adresse: json['adresse'],
        prix: json['prix']);
  }
}

class UserCredential {
  String usernameOrEmail;
  String password;
  UserCredential({this.usernameOrEmail, this.password});
}
