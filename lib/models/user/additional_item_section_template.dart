class AdditionalItemSectionTemplate {
  int id;
  String name;

  AdditionalItemSectionTemplate({
    required this.id,
    required this.name,
  });

  Map toJson() => {
        'id': id,
        'name': name,
      };

  factory AdditionalItemSectionTemplate.fromMap(Map<String, dynamic> map) {
    return AdditionalItemSectionTemplate(
      id: map['id'] ?? -1,
      name: map['name'],
    );
  }
}

extension MutableItemTemplate on AdditionalItemSectionTemplate {
  AdditionalItemSectionTemplate renameItem(String newName) {
    return copyWith(name: newName);
  }

  AdditionalItemSectionTemplate copyWith({String? name}) {
    return AdditionalItemSectionTemplate(id: id, name: name ?? this.name);
  }
}
