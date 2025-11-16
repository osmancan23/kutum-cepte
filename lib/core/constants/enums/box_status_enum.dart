// KATEGORİLER BOS , AZ DOLU , DOLU

enum BoxStatusEnum {
  empty(title: 'Kutu Boş', value: 'BOS'),
  low(title: 'Kutu Az Dolu', value: 'AZ_DOLU'),
  full(title: 'Kutu Dolu', value: 'DOLU');

  const BoxStatusEnum({required this.value, required this.title});

  final String value;
  final String title;
}
