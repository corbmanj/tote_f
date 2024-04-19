import 'package:flutter_riverpod/flutter_riverpod.dart';

class Member {
  late String type;
  late String name;
  late int id;

  Member(this.type, this.name, this.id);
}

extension MutableMember on Member {
  Member updateName({required String newName}) {
    return Member(type, newName, id);
  }
}

class MemberListNotifier extends StateNotifier<List<Member>> {
  MemberListNotifier(List<Member> newMembers)
      : super(newMembers
            .map((Member member) => Member(
                  member.type,
                  member.name,
                  member.id,
                ))
            .toList());

  void updateMemberName(int memberId, String newName) {
    final List<Member> newMembers = state;
    state = newMembers
        .map((Member member) => member.id == memberId
            ? member.updateName(newName: newName)
            : member)
        .toList();
  }

  void setMembers() {
    state = [
      Member("one", "one", 1),
      Member("two", "two", 2),
      Member("three", "three", 3),
    ];
  }
}

final memberListProvider =
    StateNotifierProvider<MemberListNotifier, List<Member>>((ref) {
  return MemberListNotifier([]);
});
