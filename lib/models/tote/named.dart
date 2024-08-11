class Named {
  String name;
  String parentType;
  int ordering;
  bool isPacked;

  Named(this.name, this.parentType, this.ordering, [this.isPacked = false]);

  Map toJson() => {
        'name': name,
        'parentType': parentType,
        'ordering': ordering,
        'isPacked': isPacked,
      };

  factory Named.fromMap(Map<String, dynamic> map) {
    return Named(
      map['name'],
      map['parentType'],
      map['ordering'],
      map['isPacked'] ?? false,
    );
  }

  void setIsPacked(bool newValue) {
    isPacked = newValue;
  }
}

extension MutableNamed on Named {
  Named copyWith({String? name, String? parentType, int? ordering, bool? isPacked}) {
    return Named(name ?? this.name, parentType ?? this.parentType,
        ordering ?? this.ordering, isPacked ?? this.isPacked);
  }

  Named updateName({required String newName}) {
    return copyWith(name: newName);
  }
}
