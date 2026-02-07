bool isUppercase(String s) {
  // Check if the string has at least one letter character
  bool hasLetters = false;

  for (final codeUnit in s.codeUnits) {
    // A-Z ASCII range
    if (codeUnit >= 65 && codeUnit <= 90) {
      hasLetters = true;
    }
    // a-z ASCII range
    else if (codeUnit >= 97 && codeUnit <= 122) {
      // If a lowercase letter is found, the string is not fully uppercase
      return false;
    }
  }

  // The string is uppercase only if it contains letters and no lowercase letters
  return hasLetters;
}


extension StringHelpers on String {

  bool isUppercase(String s) {
    bool hasLetters = false;
    for (final codeUnit in s.codeUnits) {
      if (codeUnit >= 65 && codeUnit <= 90) {
        hasLetters = true;
      } else if (codeUnit >= 97 && codeUnit <= 122) {
        return false;
      }
    }
    return hasLetters;
  }

  String toTitleCase() {
    if (this.isEmpty) {
      return this;
    }
    // Split the string into words, capitalize the first letter of each, and rejoin
    return this.split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

}