import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:marchant_ambulant_gui/constants.dart';
import 'package:marchant_ambulant_gui/models/produit.dart';
import 'package:marchant_ambulant_gui/services/produit_service.dart';

class Recherche extends StatefulWidget {
  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  final ProduitService _produitService = new ProduitService();
  String valNotFound = '';
  final SearchBarController<Produit> _searchBarController =
      SearchBarController();
  bool isReplay = false;

  Future<List<Produit>> _getALlProduits(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    if (isReplay) return this._produitService.searchProduit(text);

    List<Produit> produits = await this._produitService.searchProduit(text);
    print('MAWATTA CAMARA');
    print(text);
    return produits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<Produit>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 2),
          headerPadding: EdgeInsets.symmetric(horizontal: 2),
          listPadding: EdgeInsets.symmetric(horizontal: 2),
          onSearch: (text) => _getALlProduits(text),
          searchBarController: _searchBarController,
          placeHolder: Text("placeholder"),
          cancellationWidget: Text("Cancel"),
          emptyWidget:
              Text("Aucun produit correspondant dans notre base de donnée"),
          indexedScaledTileBuilder: (int index) =>
              ScaledTile.count(1, index.isEven ? 2 : 1),
          header: Row(
            children: <Widget>[
              RaisedButton(
                child: Text("En Ordre"),
                onPressed: () {
                  _searchBarController.sortList((Produit a, Produit b) {
                    return a.designation.compareTo(b.designation);
                  });
                },
              ),
              RaisedButton(
                child: Text("En Desordre"),
                onPressed: () {
                  _searchBarController.removeSort();
                },
              ),
              RaisedButton(
                child: Text("Relancer Le filtre"),
                onPressed: () {
                  isReplay = !isReplay;
                  _searchBarController.replayLastSearch();
                },
              ),
            ],
          ),
          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          crossAxisCount: 1,
          minimumChars: 1,
          iconActiveColor: kPrimaryColor,
          onItemFound: (Produit produit, int index) {
            return Container(
              height: 1,
              color: kPrimaryColor,
              child: ListTile(
                isThreeLine: true,
                subtitle: Text(
                  produit.designation,
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Detail()));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
