import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/data/local/user_preferences.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/provider/tts_provider.dart';

class ButtonWidget extends ConsumerWidget {
  final String image, text;
  final Color color;
  const ButtonWidget(
      {super.key,
      required this.image,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = ref.watch(configProvider);
    Size mq = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    final UserPreferences prefs = UserPreferences();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appConfig.cardStyle != 'Solo texto'
                      ? Image.asset(
                          image,
                          height: appConfig.cardStyle == "Solo imagen"
                              ? orientation == Orientation.portrait
                                  ? mq.width * 0.6
                                  : mq.width * 0.4
                              : mq.width * 0.3,
                        )
                      : const SizedBox.shrink(),
                  appConfig.cardStyle != 'Solo imagen'
                      ? Text(
                          text.toUpperCase(),
                          style: TextStyle(
                              //fontSize: MediaQuery.of(context).size.height * 0.1,
                              fontSize: appConfig.cardStyle == "Solo texto"
                                  ? orientation == Orientation.portrait
                                      ? mq.width * 0.3
                                      : mq.height * 0.3
                                  : orientation == Orientation.portrait
                                      ? mq.width * 0.14
                                      : mq.height * 0.1,
                              fontWeight: FontWeight.bold,
                              color: prefs.highContrast
                                  ? Colors.black
                                  : Colors.white),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            onTap: () {
              HapticFeedback.lightImpact();
              ref.read(appTTSProvider.notifier).speak(text);
            },
          ),
        ),
      ),
    );
  }
}
