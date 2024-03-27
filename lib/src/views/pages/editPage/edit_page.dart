import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tarutas/src/models/ta_card.dart';
import 'package:tarutas/src/provider/card_provider.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/theme/color_app.dart';
import 'package:tarutas/src/views/pages/homePage/widgets/button_widget.dart';

class EditPage extends ConsumerStatefulWidget {
  const EditPage({super.key});

  @override
  EditPageState createState() => EditPageState();
}

class EditPageState extends ConsumerState<EditPage> {
  @override
  Widget build(BuildContext context) {
    final taCard = ref.watch(cardProvider);
    final TextEditingController titleController = TextEditingController();
    final TextEditingController textController = TextEditingController();
    final MaterialStateProperty<Icon?> checkIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );
    titleController.text = taCard.name;
    titleController.selection = TextSelection(
        baseOffset: titleController.text.length,
        extentOffset: titleController.text.length);
    textController.text = taCard.text;
    textController.selection = TextSelection(
        baseOffset: textController.text.length,
        extentOffset: textController.text.length);
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
              iconTheme: const IconThemeData(color: Colors.white),
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
                child: ButtonWidget(
                  card: TACard(
                    name: taCard.name,
                    text: taCard.text,
                    color: taCard.color,
                    isGroup: taCard.isGroup,
                    img: taCard.img,
                    id: taCard.id,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              TextField(
                controller: titleController,
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
                  hintText: 'Título',
                  hintStyle: TextStyle(
                    color: appConfig.highContrast ? Colors.white : Colors.grey,
                  ),
                ),
                onChanged: (text) {
                  ref.read(cardProvider.notifier).setTitleCard(title: text);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              TextField(
                controller: textController,
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
                      color:
                          appConfig.highContrast ? Colors.white : Colors.black,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(
                      color:
                          appConfig.highContrast ? Colors.white : Colors.black,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    borderSide: BorderSide(
                        color: appConfig.highContrast
                            ? Colors.white
                            : Colors.black,
                        width: 2),
                  ),
                  hintText: 'Texto',
                  hintStyle: TextStyle(
                    color: appConfig.highContrast ? Colors.white : Colors.grey,
                  ),
                ),
                onChanged: (text) {
                  ref.read(cardProvider.notifier).setTextCard(text: text);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              ListTile(
                title: const Text('Es un grupo'),
                trailing: Switch(
                  thumbIcon: checkIcon,
                  value: taCard.isGroup,
                  onChanged: (bool value) {
                    ref.read(cardProvider.notifier).isGroupCard(isGroup: value);
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: ColorPicker(
                    color: taCard.color.toColor,
                    onColorChanged: (Color color) => ref
                        .read(cardProvider.notifier)
                        .setColorCard(color: color.hex),
                    width: 44,
                    height: 44,
                    borderRadius: 16,
                    enableShadesSelection: false,
                    pickersEnabled: const {
                      ColorPickerType.accent: false,
                      ColorPickerType.primary: false,
                      ColorPickerType.custom: true,
                      ColorPickerType.customSecondary: false,
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              Container(
                alignment: Alignment.center,
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blue,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        'Crear ruta'.toUpperCase(),
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width *
                              0.68 *
                              appConfig.factorSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      ref.read(tARoutesProvider.notifier).setCard(card: taCard);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
