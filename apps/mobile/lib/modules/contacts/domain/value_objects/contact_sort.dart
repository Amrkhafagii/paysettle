enum ContactSort { alphabetical, recent }

extension ContactSortX on ContactSort {
  String get label {
    switch (this) {
      case ContactSort.alphabetical:
        return 'A-Z';
      case ContactSort.recent:
        return 'Recent';
    }
  }
}
