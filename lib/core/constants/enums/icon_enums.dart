import 'package:kutum_cepte_app/utils/extension/string_extension.dart';

enum IconEnums {
  activity('activity'),
  arrowDown('arrow_down'),
  arrowDown2('arrow_down2'),
  arrowLeft('arrow_left'),
  arrowRight('arrow_right'),
  arrowRight2('arrow_right2'),
  bookmark('bookmark'),
  box('box'),
  calendar('calendar'),
  call('call'),
  camera('camera'),
  check('check'),
  delete('delete'),
  editSquare('edit_square'),
  edit('edit'),
  edit2('edit2'),
  filter('filter'),
  gallery('gallery'),
  hide('hide'),
  home('home'),
  hour('hour'),
  idCard('id_card'),
  loading('loading'),
  location('location'),
  lock('lock'),
  logout('logout'),
  mail('mail'),
  minus('minus'),
  notification('notification'),
  profile('profile'),
  rating('rating'),
  ratingColor('rating_color'),
  search('search'),
  warning('warning'),
  ;

  const IconEnums(this.iconName);
  final String iconName;

  String get svgPathIcon => iconName.toSvgIc;

  String get pngPathIcon => iconName.toPngIc;
}
