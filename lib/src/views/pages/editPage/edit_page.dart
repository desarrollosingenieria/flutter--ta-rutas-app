import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarutas/src/constants/constants.dart';
import 'package:tarutas/src/models/ta_card.dart';
import 'package:tarutas/src/provider/card_provider.dart';
import 'package:tarutas/src/provider/config_provider.dart';
import 'package:tarutas/src/provider/routes_provider.dart';
import 'package:tarutas/src/theme/color_app.dart';
import 'package:tarutas/src/views/widgets/button_widget.dart';

class EditPage extends ConsumerStatefulWidget {
  final TACard? card;
  const EditPage({super.key, this.card});

  @override
  EditPageState createState() => EditPageState();
}

class EditPageState extends ConsumerState<EditPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taCard = ref.watch(cardProvider);
    final TextEditingController titleController = TextEditingController();
    final TextEditingController textController = TextEditingController();
    final WidgetStateProperty<Icon?> checkIcon =
        WidgetStateProperty.resolveWith<Icon?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
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
    final Size mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appConfig.highContrast ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          taCard.name != '' ? EDIT_ROUTE_TEXT : NEW_ROUTE_TEXT,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: TAColors.brandblue,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: mq.width > LARGE_SCREEN_SIZE ? mq.width * 0.16 : mq.width < LARGE_SCREEN_SIZE && mq.width >= MEDIUM_SCREEN_SIZE ? mq.width * 0.3 : mq.width * 0.4,
                height: mq.width > LARGE_SCREEN_SIZE ? mq.width * 0.16 : mq.width < LARGE_SCREEN_SIZE && mq.width >= MEDIUM_SCREEN_SIZE ? mq.width * 0.3 : mq.width * 0.4,
                child: AbsorbPointer(
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          appConfig.highContrast
                              ? Colors.white
                              : Colors.purple),
                    ),
                    onPressed: () {
                      _pickImageFromCamera();
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color:
                          appConfig.highContrast ? Colors.black : Colors.white,
                    ),
                  ),
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          appConfig.highContrast
                              ? Colors.white
                              : Colors.orange),
                    ),
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                    icon: Icon(
                      Icons.folder,
                      color:
                          appConfig.highContrast ? Colors.black : Colors.white,
                    ),
                  ),
                  IconButton.filled(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          appConfig.highContrast ? Colors.white : Colors.grey),
                    ),
                    onPressed: () {
                      _pickImageFromNetwork();
                    },
                    icon: Icon(
                      Icons.link,
                      color:
                          appConfig.highContrast ? Colors.black : Colors.white,
                    ),
                  ),
                  taCard.img != ''
                      ? IconButton.filled(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.red)),
                          onPressed: () {
                            ref.read(cardProvider.notifier).setImgCard(img: '');
                          },
                          icon: const Icon(
                            Icons.close,
                          ))
                      : const SizedBox.shrink(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              TextField(
                controller: titleController,
                enableInteractiveSelection: false,
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
                enableInteractiveSelection: false,
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
                  hintText: 'Texto a pronunciar',
                  hintStyle: TextStyle(
                    color: appConfig.highContrast ? Colors.white : Colors.grey,
                  ),
                ),
                onChanged: (text) {
                  ref.read(cardProvider.notifier).setTextCard(text: text);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              ListTile(
                title: Text(
                  'Es un grupo',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: appConfig.highContrast
                          ? Colors.white
                          : TAColors.brandblue),
                ),
                tileColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                subtitle: Text(
                  'Selecciona si quieres agregar más rutas dentro de esta.',
                  style: TextStyle(
                      color: appConfig.highContrast
                          ? Colors.white
                          : TAColors.brandblue),
                ),
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
                    enableOpacity: false,
                    enableTonalPalette: false,
                    customColorSwatchesAndNames: {
                      Colors.red: "Rojo",
                      Colors.green: "Verde",
                      Colors.blue: "Azul",
                      Colors.yellow: "Amarillo",
                      Colors.pink: "Rosa",
                      Colors.purple: "Violeta",
                      Colors.deepPurple: "Violeta oscuro",
                      Colors.orange: "Anaranjado",
                      Colors.deepOrange: "Anaranjado oscuro",
                      Colors.grey: "Gris",
                    },
                    elevation: 0,
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
              Material(
                borderRadius: BorderRadius.circular(16),
                color: appConfig.highContrast ? Colors.white : Colors.blue,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      taCard.id == 99999
                          ? 'Crear ruta'.toUpperCase()
                          : 'Guardar'.toUpperCase(),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width *
                            0.68 *
                            appConfig.factorSize,
                        fontWeight: FontWeight.bold,
                        color: appConfig.highContrast
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    ref.read(tARoutesProvider.notifier).setCard(card: taCard);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    ref.read(cardProvider.notifier).setImgCard(img: returnedImage.path);
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    ref.read(cardProvider.notifier).setImgCard(img: returnedImage.path);
  }

  Future _pickImageFromNetwork() {
    final Size mq = MediaQuery.of(context).size;
    final appConfig = ref.watch(configProvider);
    final TextEditingController imgController = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Dirección URL de la imagen',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: mq.width * 0.06,
              ),
            ),
          ),
          TextField(
            controller: imgController,
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
                  color: appConfig.highContrast ? Colors.white : Colors.black,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(
                  color: appConfig.highContrast ? Colors.white : Colors.black,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(
                    color: appConfig.highContrast ? Colors.white : Colors.black,
                    width: 2),
              ),
              hintText: 'http://',
              hintStyle: TextStyle(
                color: appConfig.highContrast ? Colors.white : Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: mq.width * 0.04,
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
                    'Finalizar'.toUpperCase(),
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
                  ref
                      .read(cardProvider.notifier)
                      .setImgCard(img: imgController.text);
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
