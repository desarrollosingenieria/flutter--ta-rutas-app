import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/data/local/user_preferences.dart';
import 'package:tarutas/src/models/ta_card.dart';
import 'package:tarutas/src/provider/card_provider.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/provider/tts_provider.dart';
import 'package:tarutas/src/theme/color_app.dart';
import 'package:tarutas/src/utils/transitions.dart';
import 'package:tarutas/src/views/pages/homePage/group_page.dart';

class ButtonWidget extends ConsumerWidget {
  final TACard card;
  final int? id;
  const ButtonWidget({super.key, required this.card, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size mq = MediaQuery.of(context).size;
    final UserPreferences prefs = UserPreferences();
    return Material(
      color: card.color.toColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              card.isGroup
                  ? Container(
                      alignment: Alignment.topRight,
                      child: const Icon(
                        Icons.arrow_circle_right_rounded,
                        size: 34,
                        color: ColorApp.brandblue,
                      ),
                    )
                  : const SizedBox.shrink(),
              Center(
                child: Text(
                  card.name.toUpperCase(),
                  style: TextStyle(
                      //fontSize: MediaQuery.of(context).size.height * 0.1,
                      fontSize: mq.height * 0.03,
                      fontWeight: FontWeight.bold,
                      color: prefs.highContrast ? Colors.black : Colors.white),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          HapticFeedback.lightImpact();
          ref.read(appTTSProvider.notifier).speak(card.text);
          if (card.isGroup) {
            Navigator.push(
              context,
              SlideLeftTransitionRoute(
                widget: GroupPage(
                  groupName: card.name.toUpperCase(),
                  groupColor: card.color.toColor,
                  idParent: card.id,
                ),
              ),
            );
          }
        },
        onLongPress: () {
          ref.read(tARoutesProvider.notifier).deleteCard(card.id);
        },
      ),
    );
  }
}
