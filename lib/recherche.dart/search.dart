import 'package:flutter/material.dart';
import 'package:marchant_ambulant_gui/blocks/produit_block.dart';
import 'package:marchant_ambulant_gui/constants.dart';
import 'package:marchant_ambulant_gui/models/produit.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate {
  List<String> listeExemple = [];
  Search({this.listeExemple});

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[IconButton(icon: Icon(Icons.close), onPressed: () {})];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          color: kPrimaryColor,
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    Future<List<Produit>> prod =
        Provider.of<ProduitBlock>(context).fetchProduits();
    return Container(
        child: StreamBuilder<List<Produit>>(
            stream: prod.asStream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Row(children: [
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            showSearch(context: context, delegate: Search());
                          })
                    ])
                  : CircularProgressIndicator();
            }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future<List<Produit>> prod =
        Provider.of<ProduitBlock>(context).fetchProduits();

    return StreamBuilder<List<Produit>>(
        stream: prod.asStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Row(children: [
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(context: context, delegate: Search());
                      })
                ])
              : CircularProgressIndicator();
        });
  }
}
