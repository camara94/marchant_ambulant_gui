import 'package:flutter/material.dart';
import 'package:marchant_ambulant_gui/accueil/accueil.dart';
import 'package:marchant_ambulant_gui/blocks/auth_block.dart';
import 'package:marchant_ambulant_gui/blocks/category_block.dart';
import 'package:marchant_ambulant_gui/blocks/produit_block.dart';
import 'package:marchant_ambulant_gui/categorieS/categories.dart';
import 'package:marchant_ambulant_gui/constants.dart';
import 'package:marchant_ambulant_gui/localizations.dart';
import 'package:marchant_ambulant_gui/panier/panier.dart';
import 'package:marchant_ambulant_gui/produit_par_category/produit_par_category.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Locale locale = Locale('en');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthBlock>.value(value: AuthBlock()),
      ChangeNotifierProvider<ProduitBlock>.value(value: ProduitBlock()),
      ChangeNotifierProvider<CategoryBlock>.value(value: CategoryBlock())
    ],
    child: MaterialApp(
      localizationsDelegates: [
        AppLocalizations(locale).delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('ar'), Locale('fr')],
      locale: locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          accentColor: kPrimaryColor,
          fontFamily: locale.languageCode == 'fr' ? 'Dubai' : 'Lato'),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Accueil(),
        '/categorise': (BuildContext context) => Categories(),
        '/cart': (BuildContext context) => Panier(),
      },
    ),
  ));
}
