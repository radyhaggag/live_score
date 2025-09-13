extension NameFormatter on String {
  /// Shorten by words instead of characters
  /// Keeps the first [maxWords], adds "…" if longer
  String shortenByWords([int maxWords = 3]) {
    final words = split(RegExp(r'\s+')); // split by whitespace
    if (words.length <= maxWords) return this;
    return words.take(maxWords).join(' ');
  }

  /// League name formatting (default: 2 words)
  String get leagueName => shortenByWords();

  /// Club name formatting (default: 2 words)
  String get teamName => shortenByWords();

  String get playerName {
    // If 3 or more words, shorten to 3 words and make the 2nd word initial only
    final words = split(RegExp(r'\s+')); // split by whitespace
    if (words.length <= 2) return this;
    if (words.length == 3) {
      return '${words[0]} ${words[1][0]}. ${words[2]}';
    }
    // 4 or more words - keep first and last, initials for middle
    final middleInitials = words
        .sublist(1, words.length - 1)
        .map((w) => '${w[0]}.')
        .join(' ');
    return '${words.first} $middleInitials ${words.last}';
  }
}
