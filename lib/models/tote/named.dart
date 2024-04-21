class Named {
  String name;
  String parentType;
  int ordering;

  Named(this.name, this.parentType, this.ordering);
}

extension MutableNamed on Named {
  Named copyWith({String? name, String? parentType, int? ordering}) {
    return Named(name ?? this.name, parentType ?? this.parentType, ordering ?? this.ordering);
  }

  Named updateName({required String newName}) {
    return copyWith(name: newName);
  }
}
