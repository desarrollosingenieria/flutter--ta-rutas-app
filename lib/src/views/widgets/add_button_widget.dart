import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/provider/card_provider.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/utils/transitions.dart';
import 'package:tarutas/src/views/pages/editPage/edit_page.dart';

class AddButtonWidget extends ConsumerWidget {
  final int? idParent;
  const AddButtonWidget({
    super.key,
    this.idParent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size mq = MediaQuery.of(context).size;
    final appConfig = ref.watch(configProvider);
    Orientation orientation = MediaQuery.of(context).orientation;
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.black.withOpacity(0.05),
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: orientation == Orientation.portrait
                    ? mq.width * appConfig.factorSize * 2
                    : mq.height * appConfig.factorSize * 2,
                color: appConfig.highContrast ? Colors.white : Colors.grey,
              ),
              Text(
                'Nuevo',
                style: TextStyle(
                    //fontSize: MediaQuery.of(context).size.height * 0.1,
                    fontSize: orientation == Orientation.portrait
                        ? mq.width * appConfig.factorSize
                        : mq.height * appConfig.factorSize,
                    fontWeight: FontWeight.bold,
                    color: appConfig.highContrast ? Colors.white : Colors.grey),
              )
            ],
          ),
          onTap: () {
            HapticFeedback.lightImpact();
            ref.read(cardProvider.notifier).restartCard(idParent: idParent);
            ref.read(cardProvider.notifier).setParentCard(idParent: idParent);
            Navigator.push(
              context,
              SlideLeftTransitionRoute(
                widget: const EditPage(),
              ),
            );
          },
        ),
      ),
    );
  }

  void showCustomDialog() {}
}
