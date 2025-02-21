import 'package:tote_f/models/user/outfit_template.dart';

class ItemTemplate {
  int id;
  String name;
  String? type;

  ItemTemplate({
    required this.id,
    required this.name,
    this.type
  });

  Map toJson() => {
        'id': id,
        'type': type
      };

  factory ItemTemplate.fromMap(Map<String, dynamic> map) {
    return ItemTemplate(
      id: map['id'] ?? -1,
      name: map['name'],
      type: map['type'],
    );
  }
}

extension MutableItemTemplate on ItemTemplate {
  ItemTemplate renameItem(String newName) {
    return copyWith(name: newName);
  }

  ItemTemplate copyWith({String? name, String? type}) {
    return ItemTemplate(id: id, name: name ?? this.name, type: type ?? this.type,);
  }
}

class ItemTemplateWithExtension extends ItemTemplate {
  OutfitTemplate? outfit;
  bool? defaultIncluded;
  ItemTemplateWithExtension({required super.id, required super.name, required super.type, this.outfit, this.defaultIncluded});

  factory ItemTemplateWithExtension.fromItemWithOutfit({required ItemTemplate item, OutfitTemplate? outfit}) {
    return ItemTemplateWithExtension(id: item.id, name: item.name, type: item.type, outfit: outfit);
  }

  factory ItemTemplateWithExtension.fromItemWithDefaultIncluded({required ItemTemplate item, bool? defaultIncluded}) {
    return ItemTemplateWithExtension(id: item.id, name: item.name, type: item.type, defaultIncluded: defaultIncluded);
  }
}