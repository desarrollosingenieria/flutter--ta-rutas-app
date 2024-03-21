import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/models/ta_card.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/theme/color_app.dart';
import 'package:tarutas/src/views/pages/homePage/widgets/button_widget.dart';

class EditPage extends ConsumerWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    final appConfig = ref.watch(configProvider);
    return Scaffold(
      backgroundColor: appConfig.highContrast ? Colors.black : Colors.white,
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? AppBar(
              title: const Text(
                'Agregar',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              backgroundColor: ColorApp.brandblue,
              centerTitle: true,
              elevation: 0,
            )
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SafeArea(
                child: SizedBox.shrink(),
              )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                child: const ButtonWidget(
                    card: TACard(
                        name: 'Familia',
                        text: 'Mi familia',
                        color: Colors.blue,
                        isGroup: true)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              TextField(
                controller: controller,
                style: TextStyle(
                  fontSize:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width *
                              1.2 *
                              appConfig.factorSize
                          : MediaQuery.of(context).size.height *
                              1.2 *
                              appConfig.factorSize,
                  fontWeight: FontWeight.bold,
                  color: appConfig.highContrast ? Colors.white : Colors.black,
                ),
                minLines: 1,
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(
                        color: appConfig.highContrast
                            ? Colors.white
                            : Colors.black,
                        width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(
                        color: appConfig.highContrast
                            ? Colors.white
                            : Colors.black,
                        width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(
                        color: appConfig.highContrast
                            ? Colors.white
                            : Colors.black,
                        width: 2),
                  ),
                  hintText: 'Texto de ruta',
                  hintStyle: TextStyle(
                    color: appConfig.highContrast ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
