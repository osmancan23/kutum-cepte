extension ListExtensions<T extends dynamic> on List<T> {
  ///MARK: - Get List Item with index safely
  T? getListItem(int index) => (length > index) ? elementAt(index) : null;
}
