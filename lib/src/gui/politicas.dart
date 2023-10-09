import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:te_escucha/src/gui/home.dart';
import 'dart:ui_web';
import 'dart:ui' as ui;
import 'dart:html' as html;

import '../model/const.dart';

const MarkDownText = """
## **Datos de Ley**\n
---
\n
**Razón Social**: Instituto Nacional de los Espacio Acuáticos (INEA).\n
**R.I.F.**: G-200021411.\n
**Domicilio Principal**: Av. Orinoco entre Perijá y Mucuchíes, edificio INEA.\n

A través de este documento, la aplicación **INEA Te Escucha** recoge su Política de
Privacidad.\n

Nos aseguramos de que los datos de carácter personal proporcionados por nuestros
usuarios y potenciales usuario tengan la máxima reserva y protección.
Respetamos la confidencialidad y privacidad de la información suministradas por nuestros
usuarios y de todas aquellas personas interesadas en los servicios y/o productos
ofrecidos a través de nuestra plataforma web.\n

#### **Política de Privacidad para INEA Te Escucha**

Para el INEA la política de privacidad tiene como objeto informar acerca de cómo
recopilamos, seguimos y compartimos su información y de cómo nos comprometemos a
la protección de sus datos. Esta información es importante, esperamos que dedique el
tiempo necesario a leerla. Su privacidad es muy importante para nosotros.\n
La política de privacidad puede ser modificada, ya sea por el uso de nuevas tecnologías
de procesamiento de información, o cambios que pudiéramos introducir en nuestra
aplicación y a nuestras herramientas de comunicación. Todas las veces que
modifiquemos esta política lo comunicaremos, de manera que pueda estar siempre al
tanto de la misma. No limitaremos los derechos que le corresponden con arreglo a la
presente política de privacidad sin su expreso consentimiento.\n

#### **Confidencialidad del tratamiento de los datos personales**

Aseguramos la confidencialidad de los datos personales de los usuarios que se registren
en la aplicación INEA Te Escucha mediante el formulario establecido para esos efectos.
Sin perjuicio de sus facultades legales, sólo efectuaremos tratamiento de datos
personales respecto a aquellos que han sido entregados voluntariamente por los usuarios
en los referidos formularios.\n

#### **Seguridad de su información personal**

Sus datos personales le corresponden sólo a usted y INEA Te Escucha es responsable de
no revelar ninguna clase de información que le pertenezca. Para ello, se usan los
sistemas más avanzados y se actualizan constantemente para asegurar que no existan
accesos no autorizados. Como excepción sólo compartiremos sus datos personales por
motivos legales. En este caso, sólo si consideramos de buena fe que existe una
necesidad razonable de acceder a dichos datos o utilizarlos, ya sea para cumplir con
cualquier legislación o normativa, o atender a requerimientos legales, para cumplir con
investigaciones de posibles infracciones y para proteger los derechos de los usuarios en
la medida exigida por la legislación aplicable.

#### **Obtención de su información**

Sus datos personales consignados en esta aplicación son suministrados por usted mismo,
haciendo uso entero de su libertad. La información aquí almacenada sólo comprende
datos básicos ingresados mediante formularios de contacto u otros similares.\n

#### **Uso de la información recogida**

Los datos personales de los usuarios serán utilizados para el cumplimiento de los fines
indicados en el formulario correspondiente y siempre dentro de la competencia y
atribuciones de INEA Te Escucha, conectar con las gerencias u oficinas del INEA que
debe atender cada caso. Al proporcionarnos sus datos personales, estando de acuerdo
con la política de privacidad aquí consignada, nos autoriza para el siguiente uso y
tratamiento de su información:

1. Proporcionar nuestros productos, lo que incluye la actualización, protección y
solución de problemas, así como facilitar mejoras en nuestros procesos internos.
También incluye compartir datos, cuando sea necesario para proporcionar el
servicio o realizar las transacciones que solicite.
2. Para el fin mismo por lo cual se ha suministrado;
3. Para considerarlo dentro de nuestras estadísticas de tráfico, información
estadística elaborada a partir de los datos personales de los usuarios, sin el
consentimiento expreso del titular, aunque de dichos datos no sea posible
identificar individualmente a los titulares y;
4. Para orientar mejor los servicios aquí ofrecidos y valorarlos a su criterio.\n

#### **Lo que el usuario debería saber de un vistazo**

La aplicación solo está destinada atender las quejas y reclamos, sugerencias, denuncias y
la alertar de una emergencia de embarcación.\n
La utilización de la aplicación está restringida en función de la edad: para acceder a INEA
Te Escucha y utilizarlos es preciso ser mayor de edad según la ley aplicable.\n
Ante cualquier solicitud o denuncia el instituto se comunicará con el usuario a través de
los datos proporcionado al momento del registro, en tal sentido se le recomienda colocar
los datos fidedignos, para así contactarlo y atenderlo de manera directa.\n
Ni la aplicación ni el Instituto le solicitará por correo o por ninguna vía, datos personales
tales como claves o información privada.\n

#### **Condiciones de Uso**

Las condiciones de uso detalladas se aplicarán de forma general al uso de la aplicación.
Al utilizar INEA Te Escucha, los usuarios confirman que cumplen los siguientes requisitos.\n
- Los usuarios deberán entrar en la categoría de denunciante.
- Los usuarios deberán ser mayores de edad de acuerdo con la ley.\n

#### **Registro en la Aplicación**

Para utilizar la aplicación se deberán registrar, facilitando todos los datos o la información
exigidos de forma completa y fidedigna. En caso de no hacerlo la aplicación no le
permitirá realizar ninguna solicitud.\n

Los usuarios son responsables de la custodia de sus credenciales de acceso con
garantías de confidencialidad y seguridad.\n

Al registrarse, los usuarios acuerdan asumir plena responsabilidad por todas las
actividades que tengan lugar bajo su nombre de usuario.
""";

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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/group/fondo_baselegal.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.only(top: 40),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Markdown(
              selectable: true,
              data: MarkDownText,
            ),
          ),
        ));
  }

  void homePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }
}
