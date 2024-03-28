import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/theme/color_app.dart';
import 'package:tarutas/src/views/pages/groupPage/widgets/group_widget.dart';

class GroupPage extends ConsumerWidget {
  final String? groupName;
  final Color? groupColor;
  final int? idParent;
  const GroupPage({super.key, this.groupName, this.groupColor, this.idParent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(configProvider);
    return Scaffold(
      backgroundColor: appConfig.highContrast ? Colors.black : Colors.white,
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? AppBar(
              title: Text(
                groupName ?? 'TA Rutas',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              backgroundColor: groupColor ?? ColorApp.brandblue,
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              elevation: 0,
            )
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SafeArea(
                child: SizedBox.shrink(),
              )),
      body: GroupWidget(idParent: idParent),
    );
  }
}
