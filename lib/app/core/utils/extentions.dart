extension ListEXT<T> on List<T> {
  T? search(dynamic element) {
    final index = indexWhere((e) => (e as dynamic)?.identify == element);
    if (index >= 0) {
      return this[index];
    }
    return null;
  }
}