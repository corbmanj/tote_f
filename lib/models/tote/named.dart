class Named {
  String name;
  String grouping;
  int ordering;
  bool isPacked;

  Named(this.name, this.grouping, this.ordering, [this.isPacked = false]);

  Map toJson() => {
        'name': name,
        'grouping': grouping,
        'ordering': ordering,
        'isPacked': isPacked,
      };

  factory Named.fromMap(Map<String, dynamic> map) {
    return Named(
      map['name'],
      map['grouping'],
      map['ordering'],
      map['isPacked'] ?? false,
    );
  }

  void setIsPacked(bool newValue) {
    isPacked = newValue;
  }
}

extension MutableNamed on Named {
  Named copyWith({String? name, String? grouping, int? ordering, bool? isPacked}) {
    return Named(name ?? this.name, grouping ?? this.grouping,
        ordering ?? this.ordering, isPacked ?? this.isPacked);
  }

  Named updateName({required String newName}) {
    return copyWith(name: newName);
  }
}
