import 'package:flutter/material.dart';
import 'package:marchant_ambulant_gui/models/produit.dart';
import 'package:marchant_ambulant_gui/produit_images/produit_images.dart';

class ProduitDetail extends StatefulWidget {
  ProduitDetail(this.produit) : super();
  final Produit produit;

  @override
  _ProduitDetailState createState() => _ProduitDetailState(this.produit);
}

class _ProduitDetailState extends State<ProduitDetail> {
  int selectedImage = 0;
  _ProduitDetailState(this.produit) : super();
  final Produit produit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(produit.designation),
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProduitImages(produit: produit),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment(-1.0, -1.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          produit.designation,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(
                                  '${produit.prix} GNF',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(('${produit.prix + produit.prix / 10} GNF'),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough)),
                            ],
                          ),
                          /*Row(
                            children: <Widget>[
                              RatingStars(
                                value: 5,
                                starSize: 16,
                                valueLabelColor: Colors.amber,
                                starColor: Colors.amber,
                              )
                            ],
                          ),*/
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment(-1.0, -1.0),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                        Container(
                            alignment: Alignment(-1.0, -1.0),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                '${produit.description}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
