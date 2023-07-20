import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:te_escucha/src/model/const.dart';

class CmbKeyValue {
  const CmbKeyValue(this.id, this.name);

  final String name;
  final String id;
}

class Combo extends StatefulWidget {
  const Combo({super.key, required this.width, required this.lst});

  final List<String> lst;
  final double width;

  @override
  State<Combo> createState() => _ComboState();
}

class _ComboState extends State<Combo> {
  String? dropdownValue = "---------------";

  @override
  Widget build(BuildContext context) {
    // dropdownValue = widget.lst.first;

    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
          padding: EdgeInsets.only(left: 9, right: 3),
          height: 40,
          width: widget.width,
          // color: Color(0xff83cacc),
          decoration: boxDecoration,
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down_sharp),
            elevation: 16,
            style: cmbGeneral,
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                simpleDialog(true);
              });
            },
            underline: Container(),
            items: widget.lst
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          e,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ))
                .toList(),
            isExpanded: true,
          )),
    );
  }

  void simpleDialog(bool tipo) {
    // return
    Dialogs.materialDialog(
        titleStyle: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold),
        msgStyle: const TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontFamily: "Roboto",
        ),
        msg:
            'Usala con conciencia. El envio de un reporte engañoso puede generar consecuencias legales \n\nEsta APP está protegida por la Politica de privacidad y los Terminos de Servicios que aplican',
        title:
            "INEA te escucha es una APP para atender tus reclamos, sugerencias y quejas",
        color: Colors.white,
        context: context,
        actions: [
          IconsButton(
            //IconsOutlineButton
            text: 'OK',
            onPressed: () {
              Navigator.of(context).pop();
            },

            color: const Color(0xff174076),
            textStyle:
                const TextStyle(color: Colors.white, fontFamily: "Roboto"),
          ),
        ]);
  }
}
