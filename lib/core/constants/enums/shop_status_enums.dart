enum ShopStatusEnum {
  givingBack(title: 'İade', value: 'IADE'),
  lost(title: 'Kayıp', value: 'KAYIP'),
  closed(title: 'Kapalı', value: 'KAPALI'),
  collected(title: 'Toplandı', value: 'TOPLANDI'),
  ;

  const ShopStatusEnum({required this.title, required this.value});

  final String title;
  final String value;
}
