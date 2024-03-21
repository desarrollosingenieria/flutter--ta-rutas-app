import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/provider/config_provider.dart';

class GroupPage extends ConsumerWidget {
  final String groupName;
  final Color groupColor;
  const GroupPage(
      {super.key, required this.groupName, required this.groupColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(configProvider);
    return Scaffold(
      backgroundColor: appConfig.highContrast ? Colors.black : Colors.white,
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? AppBar(
              title: Text(
                groupName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              backgroundColor: groupColor,
              centerTitle: true,
              elevation: 0,
            )
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SafeArea(
                child: SizedBox.shrink(),
              )),
      body: Container(),
    );
  }
}
