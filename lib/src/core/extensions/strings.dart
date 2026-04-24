extension NameFormatter on String {
  /// Shorten by words instead of characters
  /// Keeps the first [maxWords], adds "…" if longer
  String shortenByWords([int maxWords = 3]) {
    final words = split(RegExp(r'\s+')); // split by whitespace
    if (words.length <= maxWords) return this;
    return words.take(maxWords).join(' ');
  }
}
