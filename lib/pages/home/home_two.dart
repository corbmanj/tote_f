import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/container.dart';
import '../../models/member.dart';

class HomeTwo extends ConsumerWidget {
  const HomeTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containerRef = ref.watch(containerProvider);
    final buttons = containerRef.members;
    // final members = ref.watch(memberListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Container")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  ref.read(memberListProvider.notifier).setMembers();
                },
                child: const Text("set members")),
            ...buttons
                .map((Member button) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          maximumSize: const Size(200, 50),
                          minimumSize: const Size(200, 50)),
                      onPressed: () {
                        ref
                            .read(memberListProvider.notifier)
                            .updateMemberName(button.id, "four");
                      },
                      child: Text(button.name),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
