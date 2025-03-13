class AdditionalItemTemplate {
  int id;
  String name;
  int? sectionId;
  bool defaultIncluded;

  AdditionalItemTemplate({
    required this.id,
    required this.name,
    this.sectionId,
    required this.defaultIncluded
  });

  Map toJson() => {
        'id': id,
        'name': name,
        'sectionId': sectionId,
        'defaultIncluded': defaultIncluded ? 1 : 0
      };

  factory AdditionalItemTemplate.fromMap(Map<String, dynamic> map) {
    return AdditionalItemTemplate(
      id: map['id'] ?? -1,
      name: map['name'],
      sectionId: map['sectionId'],
      defaultIncluded: map['defaultIncluded'] == 1,
    );
  }
}

extension MutableItemTemplate on AdditionalItemTemplate {
  AdditionalItemTemplate renameItem(String newName) {
    return copyWith(name: newName);
  }

  AdditionalItemTemplate setSection(int? newValue) {
    return copyWith(sectionId: newValue);
  }

  AdditionalItemTemplate clearSection() {
    return AdditionalItemTemplate(id: id, name: name, sectionId: null, defaultIncluded: defaultIncluded);
  }

  AdditionalItemTemplate copyWith({String? name, int? sectionId, bool? defaultIncluded}) {
    return AdditionalItemTemplate(id: id, name: name ?? this.name, sectionId: sectionId ?? this.sectionId, defaultIncluded: defaultIncluded ?? this.defaultIncluded,);
  }
}

// class ItemTemplateWithExtension extends AdditionalItemTemplate {
//   OutfitTemplate? outfit;
//   bool? defaultIncluded;
//   ItemTemplateWithExtension({required super.id, required super.name, required super.grouping, required super.generic, this.outfit, this.defaultIncluded});

//   factory ItemTemplateWithExtension.fromItemWithOutfit({required AdditionalItemTemplate item, OutfitTemplate? outfit}) {
//     return ItemTemplateWithExtension(id: item.id, name: item.name, grouping: item.grouping, generic: item.generic, outfit: outfit);
//   }

//   factory ItemTemplateWithExtension.fromItemWithDefaultIncluded({required AdditionalItemTemplate item, bool? defaultIncluded}) {
//     return ItemTemplateWithExtension(id: item.id, name: item.name, grouping: item.grouping, generic: item.generic, defaultIncluded: defaultIncluded);
//   }
// }