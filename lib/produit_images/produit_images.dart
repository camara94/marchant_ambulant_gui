import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marchant_ambulant_gui/config.dart';
import 'package:marchant_ambulant_gui/constants.dart';
import 'package:marchant_ambulant_gui/models/produit.dart';
import 'package:marchant_ambulant_gui/size_config.dart';

class ProduitImages extends StatefulWidget {
  final Produit produit;
  const ProduitImages({this.produit}) : super();

  @override
  _ProduitImagesState createState() => _ProduitImagesState(produit: produit);
}

class _ProduitImagesState extends State<ProduitImages> {
  final Produit produit;
  int selectedImage = 0;
  _ProduitImagesState({this.produit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 90,
          height: 260,
          child: Hero(
            tag: widget.produit.designation,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: BASE_URL + '/' + produit.images[selectedImage],
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(produit.images.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(50),
        width: getProportionateScreenWidth(50),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(BASE_URL + '/' + widget.produit.images[index]),
      ),
    );
  }
}
