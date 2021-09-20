import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marchant_ambulant_gui/blocks/category_block.dart';
import 'package:marchant_ambulant_gui/blocks/produit_block.dart';
import 'package:marchant_ambulant_gui/config.dart';
import 'package:marchant_ambulant_gui/models/category.dart';
import 'package:marchant_ambulant_gui/models/produit.dart';
import 'package:marchant_ambulant_gui/produit_detail/produit_detail.dart';
import 'package:marchant_ambulant_gui/recherche.dart/recherche.dart';
import 'package:marchant_ambulant_gui/recherche.dart/search.dart';
import 'package:provider/provider.dart';

import 'drawer.dart';
import 'slider.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    Future<List<Produit>> produits =
        Provider.of<ProduitBlock>(context).fetchProduits();
    Future<List<Category>> categories =
        Provider.of<CategoryBlock>(context).fetchCategories();
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(),
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: CustomScrollView(
            // Add the app bar and list of items as slivers in the next steps.
            slivers: <Widget>[
              SliverAppBar(
                // Provide a standard title.
                // title: Text('asdas'),
                // pinned: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          return Recherche();
                        },
                      ));
                      //showSearch(context: context, delegate: Search());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {},
                  )
                ],
                // Allows the user to reveal the app bar if they begin scrolling
                // back up the list of items.
                // floating: true,
                // Display a placeholder widget to visualize the shrinking size.
                flexibleSpace: HomeSlider(),
                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight: 300,
              ),
              SliverList(
                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
                  // The builder function returns a ListTile with a title that
                  // displays the index of the current item.
                  (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(top: 14.0, left: 8.0, right: 8.0),
                        child: Text('LES NOUVEAUTES',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          height: 240.0,
                          child: StreamBuilder<List<Produit>>(
                            stream: produits.asStream(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Produit>> snapshot) {
                              return snapshot.hasData
                                  ? ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: snapshot.data.map((produit) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                              width: 140.0,
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context, '/products',
                                                        arguments: produit);
                                                  },
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 160,
                                                        child: Hero(
                                                          tag: '$produit',
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl: BASE_URL +
                                                                '/' +
                                                                produit
                                                                    .images[0],
                                                            placeholder: (context,
                                                                    url) =>
                                                                Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                new Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                      ),
                                                      ListTile(
                                                        title: Text(
                                                          produit.designation,
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        subtitle: Text(
                                                            '${produit.prix} GNF',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    )
                                  : Container(
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                            },
                          )),
                      Container(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/banner-1.png'),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0),
                            child: Text('Tous les produits',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, top: 8.0, left: 8.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor),
                                child: Text('Afficher par catégory',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/categorise');
                                }),
                          )
                        ],
                      ),
                      Container(
                        child: StreamBuilder<List<Produit>>(
                          stream: produits.asStream(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            var prodLength =
                                snapshot.hasData ? snapshot.data.length : 0;
                            return GridView.count(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              padding: EdgeInsets.only(
                                  top: 8, left: 6, right: 6, bottom: 12),
                              children: List.generate(prodLength, (index) {
                                return Container(
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: InkWell(
                                      onTap: () {
                                        print(snapshot.data[index].designation);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ProduitDetail(
                                                      snapshot.data[index])),
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2) -
                                                90,
                                            width: double.infinity,
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: BASE_URL +
                                                  '/' +
                                                  snapshot
                                                      .data[index].images[0],
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              '${snapshot.data[index].designation}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16),
                                            ),
                                            subtitle: Text(
                                                '${snapshot.data[index].prix} GNF',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 6.0, left: 8.0, right: 8.0, bottom: 10),
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/banner-2.png'),
                          ),
                        ),
                      )
                    ],
                  ),
                  // Builds 1000 ListTiles
                  childCount: 1,
                ),
              )
            ]),
      ),
    );
  }
}
