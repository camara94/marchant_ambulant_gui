import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:marchant_ambulant_gui/blocks/category_block.dart';
import 'package:marchant_ambulant_gui/config.dart';
import 'package:marchant_ambulant_gui/constants.dart';
import 'package:marchant_ambulant_gui/models/category.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    Future<List<Category>> categories =
        Provider.of<CategoryBlock>(context).fetchCategories();
    return Scaffold(
      appBar: AppBar(
        title: Text('Les catégories'),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
          top: false,
          left: false,
          right: false,
          child: StreamBuilder<List<Category>>(
            stream: categories.asStream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                child: ListView(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.only(top: 8, left: 6, right: 6, bottom: 8),
                  children: List.generate(
                      snapshot.hasData ? snapshot.data.length : 0, (index) {
                    if (!snapshot.hasError) {
                      return snapshot.hasData
                          ? Container(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    print('Card tapped.');
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 130,
                                        width: double.infinity,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: BASE_URL +
                                              '/' +
                                              snapshot.data[index].image,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                        ),
                                      ),
                                      ListTile(
                                          title: Text(
                                        '${snapshot.data[index].nom}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : CircularProgressIndicator();
                    } else {
                      return Card(
                        elevation: 2,
                        child: ListTile(subtitle: Text(snapshot.error)),
                      );
                    }
                  }),
                ),
              );
            },
          )),
    );
  }
}
