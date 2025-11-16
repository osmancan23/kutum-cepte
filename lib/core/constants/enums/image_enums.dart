import 'package:kutum_cepte_app/utils/extension/string_extension.dart';

enum ImageEnums {
  avatar('avatar'),
  cardActivity('card_activity'),
  login('login'),
  logo('logo'),
  identityCard('identity_card'),
  pp('pp'),
  ;

  const ImageEnums(this.imageName);
  final String imageName;

  String get svgPath => imageName.toSvg;

  String get pngPath => imageName.toPng;
}
