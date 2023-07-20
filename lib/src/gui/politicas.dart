import 'package:flutter/material.dart';

import '../model/const.dart';

class Politicas extends StatefulWidget {
  const Politicas({super.key});

  @override
  State<Politicas> createState() => _PoliticasState();
}

class _PoliticasState extends State<Politicas> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      // drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: const BackButton(
          color: Color(0xff174076),
        ),
      ),
      body: StackBody(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   backgroundColor: Colors.transparent,
      //   child: IconButton(
      //     icon: Image.asset("assets/group/chatbot.png"),
      //     iconSize: 256,
      //     onPressed: () {
      //       Chat();
      //     },
      //   ),
      // ),
    );
  }

  Stack StackBody() {
    return Stack(
      children: [
        ListView(scrollDirection: Axis.vertical, children: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Datos de Ley:",
                    style: subTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "- Razón Social: Instituto Nacional de los Espacio Acuáticos (INEA) \n- R.I.F.: G-200021411 \n- Domicilio Principal: Av. Orinoco entre Perijá y Mucuchíes, edificio INEA.",
                    style: normalTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "A través de este documento, la aplicación INEA Te Escucha recoge su Política de Privacidad. \n\n Nos aseguramos de que los datos de carácter personal proporcionados por nuestros usuarios y potenciales usuario tengan la máxima reserva y protección. \n\n Respetamos la confidencialidad y privacidad de la información privada y datos personales de nuestros usuarios y de todas aquellas personas interesadas en los servicios y/o productos ofrecidos a través de nuestra plataforma web.",
                    style: normalTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Política de Privacidad para INEA Te Escucha",
                    style: subTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Para INEA Te Escucha la política de privacidad tiene como objeto informarle acerca de cómo recopilamos, seguimos y compartimos su información y de cómo nos comprometemos a la protección de sus datos. Esta información es importante, esperamos que dedique el tiempo necesario a leerla. Su privacidad es muy importante para nosotros. Esta política puede ser modificada, ya sea por el uso de nuevas tecnologías de procesamiento de información, o cambios que pudiéramos introducir en nuestra aplicación y a nuestras herramientas de comunicación. Todas las veces que modifiquemos esta política lo comunicaremos, de manera que pueda estar siempre al tanto de la misma. No limitaremos los derechos que le corresponden con arreglo a la presente política de privacidad sin su expreso consentimiento.",
                    style: normalTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Confidencialidad del tratamiento de los datos personales",
                    style: subTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Aseguramos la confidencialidad de los datos personales de los usuarios que se registren en la aplicación INEA Te Escucha mediante el formulario establecido para esos efectos.Sin perjuicio de sus facultades legales, sólo efectuaremos tratamiento de datos personales respecto a aquellos que han sido entregados voluntariamente por los usuarios en los referidos formularios.",
                    style: normalTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Seguridad de su información personal",
                    style: subTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sus datos personales le corresponden sólo a usted y INEA Te Escucha es responsable de no revelar ninguna clase de información que le pertenezca. Para ello, se usan los sistemas más avanzados y se actualizan constantemente para asegurar que no existan accesos no autorizados. Como excepción sólo compartiremos sus datos personales por motivos legales. En este caso, sólo si consideramos de buena fe que existe una necesidad razonable de acceder a dichos datos o utilizarlos, ya sea para cumplir con cualquier legislación o normativa, o atender a requerimientos legales, para cumplir con investigaciones de posibles infracciones y para proteger los derechos de los usuarios en la medida exigida por la legislación aplicable.",
                    style: normalTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Obtención de su información",
                    style: subTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sus datos personales consignados en esta aplicación son suministrados por usted mismo, haciendo uso entero de su libertad. La información aquí almacenada sólo comprende datos básicos ingresados mediante formularios de contacto u otros similares.",
                    style: normalTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Uso de la información recogida",
                    style: subTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Los datos personales de los usuarios serán utilizados para el cumplimiento de los fines indicados en el formulario correspondiente y siempre dentro de la competencia y atribuciones de INEA Te Escucha, conectar con las gerencias u oficinas del INEA que debe atender cada caso. Al proporcionarnos sus datos personales, estando de acuerdo con la política de privacidad aquí consignada, nos autoriza para el siguiente uso y tratamiento de su información:",
                    style: normalTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "1. Proporcionar nuestros productos, lo que incluye la actualización, protección y solución de problemas, así como facilitar mejoras en nuestros procesos internos. También incluye compartir datos, cuando sea necesario para proporcionar el servicio o realizar las transacciones que solicite. \n\n 2. Para el fin mismo por lo cual se ha suministrado; \n\n 3. Para considerarlo dentro de nuestras estadísticas de tráfico, información estadística elaborada a partir de los datos personales de los usuarios, sin el consentimiento expreso del titular, aunque de dichos datos no sea posible identificar individualmente a los titulares y; \n\n 4. Para orientar mejor los servicios aquí ofrecidos y valorarlos a su criterio.",
                    style: normalTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Lo que el usuario debería saber de un vistazo",
                    style: subTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "La aplicación solo está destinada atender las quejas y reclamos, sugerencias y denuncias. La utilización de la aplicación está restringida en función de la edad: para acceder a INEA Te Escucha y utilizarlos es preciso ser mayor de edad según la ley aplicable.\n\n Ante cualquier solicitud o denuncia el instituto se comunicará con el usuario a través de los datos proporcionado al momento del registro, en tal sentido se le recomienda colocar los datos fidedignos, para así contactarlo y atenderlo de manera directa.\n\n Ni la aplicación ni el Instituto le solicitara por correo o por ninguna vía, datos personales tales como claves o información privada.",
                    style: normalTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Condiciones de uso",
                    style: subTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Las condiciones de uso detalladas se aplicarán de forma general al uso de la aplicación. Al utilizar INEA Te Escucha, los usuarios confirman que cumplen los siguientes requisitos.\n\n1.- Los usuarios deberán entrar en la categoría de denunciante. \n\n2.- Los usuarios deberán ser mayores de edad de acuerdo con la ley.",
                    style: normalTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Registro en la Aplicación",
                    style: subTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "",
                    style: normalTituloFuente,
                    textAlign: TextAlign.justify,
                  ),
                ]),
          )
        ]),
      ],
    );
  }
}
