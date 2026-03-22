extension PluralExtension on int {
  String plural({
    required String one,
    required String few,
    required String many,
  }) {
    if (this % 10 == 1 && this % 100 != 11) {
      return one;
    } else if ([2, 3, 4].contains(this % 10) &&
        ![12, 13, 14].contains(this % 100)) {
      return few;
    } else {
      return many;
    }
  }
}