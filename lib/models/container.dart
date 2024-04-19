import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'member.dart';

class Container {
  late String type;
  late String name;
  late List<Member> members;
  late int id;

  Container(this.type, this.name, this.members, this.id);
}

extension MutableContainer on Container {
  Container addMember({
    required String memberType,
    required String memberName,
    required int memberId,
  }) {
    final newMembers = [...members, Member(type, name, id)];
    return Container(type, name, newMembers, id);
  }

  List<Member> updateNameById(int memberId, String newName) {
    return members
        .map((Member member) => member.id == memberId
            ? member.updateName(newName: newName)
            : member)
        .toList();
  }
}

final containerProvider = Provider<Container>((ref) {
  final members = ref.watch(memberListProvider);
  return Container("", "", members, 0);
});
