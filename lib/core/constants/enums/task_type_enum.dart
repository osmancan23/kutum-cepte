enum TaskType {
  collector(title: 'Toplayıcı'),

  distributor(title: 'Dağıtıcı'),
  ;

  const TaskType({required this.title});

  final String title;
}
