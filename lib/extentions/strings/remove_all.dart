extension RemoveAll on String {
  String removeAll(Iterable<String> values) => values.fold(
        this,
        (previousValue, element) => previousValue.replaceAll(
          element,
          '',
        ),
      );
}
