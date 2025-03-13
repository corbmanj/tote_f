import 'package:tote_f/models/user/outfit_template.dart';

class ItemTemplate {
  int id;
  String name;
  String? grouping;
  bool? generic;

  ItemTemplate({
    required this.id,
    required this.name,
    this.grouping,
    this.generic
  });

  Map toJson() => {
        'id': id,
        'name': name,
        'grouping': grouping,
        'generic': generic == true ? 1 : 0
      };

  factory ItemTemplate.fromMap(Map<String, dynamic> map) {
    return ItemTemplate(
      id: map['id'] ?? -1,
      name: map['name'],
      grouping: map['grouping'],
      generic: map['generic'] == 1,
    );
  }
}

extension MutableItemTemplate on ItemTemplate {
  ItemTemplate renameItem(String newName) {
    return copyWith(name: newName);
  }

  ItemTemplate setIsGeneric(bool newValue) {
    return copyWith(generic: newValue);
  }

  ItemTemplate setGrouping(String newValue) {
    return copyWith(grouping: newValue);
  }

  ItemTemplate copyWith({String? name, String? grouping, bool? generic}) {
    return ItemTemplate(id: id, name: name ?? this.name, grouping: grouping ?? this.grouping, generic: generic ?? this.generic,);
  }
}

class ItemTemplateWithExtension extends ItemTemplate {
  OutfitTemplate? outfit;
  bool? defaultIncluded;
  ItemTemplateWithExtension({required super.id, required super.name, required super.grouping, required super.generic, this.outfit, this.defaultIncluded});

  factory ItemTemplateWithExtension.fromItemWithOutfit({required ItemTemplate item, OutfitTemplate? outfit}) {
    return ItemTemplateWithExtension(id: item.id, name: item.name, grouping: item.grouping, generic: item.generic, outfit: outfit);
  }

  factory ItemTemplateWithExtension.fromItemWithDefaultIncluded({required ItemTemplate item, bool? defaultIncluded}) {
    return ItemTemplateWithExtension(id: item.id, name: item.name, grouping: item.grouping, generic: item.generic, defaultIncluded: defaultIncluded);
  }
}