import 'dart:ui_web';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:te_escucha/src/gui/ver_mensaje.dart';
import 'package:te_escucha/src/model/const.dart';

class CBuzon extends StatelessWidget {
  final String titulo;
  final String codigo;
  final String img;
  final String icono;
  final int status;
  final String txtStatus;
  final String contenido;
  final String categoria;
  final String respuesta;
  final String fecha;
  final Color fondo;
  final Color border;
  final String correo;

  CBuzon(
      {super.key,
      required this.codigo,
      required this.titulo,
      required this.status,
      required this.txtStatus,
      required this.fondo,
      required this.border,
      required this.fecha,
      required this.icono,
      required this.contenido,
      required this.categoria,
      required this.respuesta,
      required this.img,
      required this.correo});

  late String imagen = img == "group/g.g. operaciones"
      ? "assets/group/sar_st.png"
      : "assets/${img}_st.png";

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        child: GestureDetector(
      onTap: () => {
        verMensaje(context, contenido, titulo, respuesta, categoria, img,
            codigo, icono, status)
      },
      child: Container(
        padding: const EdgeInsets.all(1.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: fondo,
                    border: Border.all(color: border),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.all(2.0),
                    width: 100,
                    height: 100,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Image(
                          image: AssetImage(imagen),
                        ),
                        Text(
                          codigo,
                          style: textNumber,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    width: MediaQuery.of(context).size.width - 210,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: textHome,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          categoria,
                          style: textDescrip,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Fecha: ${fecha.substring(0, 10)}",
                          style: textDescrip,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        width: 70,
                        height: 70,
                        child: Image(
                          image: AssetImage('assets/estatus/$icono.png'),
                        ),
                      ),
                      Text(
                        txtStatus,
                        style: textStatus,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ]),
              )
            ]),
      ),
    ));
  }

  void verMensaje(
      BuildContext context,
      String contenido,
      String tipo,
      String respuesta,
      String categoria,
      String img,
      String codigo,
      String icono,
      int estatus) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VerMensaje(
                contenido: contenido,
                tipo: tipo,
                respuesta: respuesta,
                categoria: categoria,
                codigo: codigo,
                estatus: estatus,
                icono: icono,
                img: img,
                correo: correo,
              )),
    );
  }
}
