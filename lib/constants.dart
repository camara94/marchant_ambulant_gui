import 'package:flutter/material.dart';
import 'package:marchant_ambulant_gui/size_config.dart';

const kPrimaryColor = Color(0xFF6C4D7A);
const kPrimaryLightColor = Color(0xFFC6B4CE);
const kPrimaryPaleColor = Color(0xFF9E85A0);
const kPrimaryDarkColor = Color(0xFF030303);
const kPrimaryCyanColor = Color(0xFFBFA415);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFC6B4CE), Color(0xFF9E85A0), Color(0xFF6C4D7A)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Veuillez entrer votre email";
const String kInvalidEmailError = "Veuillez entrer un e-mail valide";
const String kPassNullError = "S'il vous plait entrez votre mot de passe";
const String kShortPassError = "Le mot de passe est trop court";
const String kMatchPassError = "Les mots de passe ne correspondent pas";
const String kNamelNullError = "S'il vous plaît entrez votre nom";
const String kPhoneNumberNullError =
    "Veuillez entrer votre numéro de téléphone";
const String kAddressNullError = "Veuillez entrer votre adresse";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
