import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/data/local/user_preferences.dart';
import 'package:tarutas/src/provider/card_provider.dart';
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
    final UserPreferences prefs = UserPreferences();
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: DottedBorder(
        color: Colors.grey,
        strokeWidth: 3,
        radius: const Radius.circular(16),
        dashPattern: const [20, 5],
        borderType: BorderType.RRect,
        child: SizedBox(
          width: double.infinity,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add,
                  size: 34,
                  color: Colors.grey,
                ),
                Text(
                  'Agregar',
                  style: TextStyle(
                      //fontSize: MediaQuery.of(context).size.height * 0.1,
                      fontSize: mq.height * 0.02,
                      fontWeight: FontWeight.bold,
                      color: prefs.highContrast ? Colors.black : Colors.grey),
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
      ),
    );
  }
}
