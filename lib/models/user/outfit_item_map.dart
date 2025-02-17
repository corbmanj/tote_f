// class OutfitItemMap {
//   int id;
//   int outfitId;
//   int itemId;
//   bool defaultIncluded;

//   OutfitItemMap(this.id, this.outfitId, this.itemId, this.defaultIncluded);

//   Map toJson() => {
//     'id': id,
//     'outfitId': outfitId,
//     'itemId': itemId,
//     'defaultIncluded': defaultIncluded == true ? 1 : 0,
//   };

//   factory OutfitItemMap.fromMap(Map<String, dynamic> map) {
//     return OutfitItemMap(
//       map['id'],
//       map['outfitId'],
//       map['itemId'],
//       map['defaultIncluded'] == 1 ? true : false,
//     );
//   }
// }