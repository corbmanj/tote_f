class Named {
  String name;
  String parentType;

  Named(this.name, this.parentType);
}

extension MutableNamed on Named {
  Named updateName({required String newName}) {
    return Named(newName, parentType);
  }
}

// class NamedItemNotifier extends StateNotifier<Named> {
//   NamedItemNotifier(Named item) : super(Named(item.name, item.parentType));
// }

// final namedItemProvider = StateNotifierProvider<NamedItemNotifier, Named>(
//     (ref) => NamedItemNotifier(Named("", "")));
