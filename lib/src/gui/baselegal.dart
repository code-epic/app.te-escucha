import 'package:flutter/material.dart';
import 'package:te_escucha/src/model/const.dart';

class BaseLegal extends StatefulWidget {
  const BaseLegal({super.key});

  @override
  State<BaseLegal> createState() => _BaseLegalState();
}

class _BaseLegalState extends State<BaseLegal> {
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
                Center(
                  child: Text(
                    "BASES LEGALES PARA EL SISTEMA",
                    style: tituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "DE ATENCIÓN AL CIUDADANO",
                    style: tituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "1. CONSTITUCIÓN DE LA REPÚBLICA BOLIVARIANA DE VENEZUELA. ",
                    style: subTituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "G.O.R.B.V N° 36.860 de fecha 30 de diciembre de 1.999.",
                    style: normalTituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Capítulo III. De los Derechos Civiles \nArtículo 51.",
                  style: subTituloFuente,
                ),
                Text(
                  "Toda persona tiene el derecho de representar o dirigir peticiones ante cualquier autoridad, funcionario público o funcionaria pública sobre los asuntos que sean de la competencia de éstos o éstas, y de obtener oportuna y adecuada respuesta. Quienes violen este derecho serán sancionados o sancionadas conforme a la ley, pudiendo ser destituidos o destituidas del cargo respectivo.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "TÍTULO IV. DEL PODER PÚBLICO ",
                  style: subTituloFuente,
                ),
                Text(
                  "Capítulo I. Sección Segunda: De la Administración Pública \nArtículo 141.",
                  style: subTituloFuente,
                ),
                Text(
                  "La Administración Pública está al servicio de los ciudadanos y ciudadanas y se fundamenta en los principios de honestidad, participación, celeridad, eficacia, eficiencia, transparencia, rendición de cuentas y responsabilidad en el ejercicio de la función pública, con sometimiento pleno a la ley y al derecho.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "2. LEY ORGÁNICA DE LA ADMINISTRACIÓN PÚBLICA. ",
                    style: subTituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "G.O.R.B.V N° 37.305 de fecha 17 de octubre de 2001.",
                    style: normalTituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 3. Objetivo de la Administración Pública ",
                  style: subTituloFuente,
                ),
                Text(
                  "La Administración Pública tendrá como objetivo de su organización y funcionamiento hacer efectivos los principios, valores y normas consagrados en la Constitución de la República Bolivariana de Venezuela y en especial, garantizar a todas las personas, el goce y ejercicio de los derechos humanos.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 5. Principio de la Administración Pública al servicio de las personas ",
                  style: subTituloFuente,
                ),
                Text(
                  "La Administración Pública está al servicio de las personas, y su actuación estará dirigida a la atención de sus requerimientos y la satisfacción de sus necesidades, brindando especial atención a las de carácter social.\n\nLa Administración Pública debe asegurar a todas las personas la efectividad de sus derechos cuando se relacionen con ella.\n\nAdemás, tendrá entre sus objetivos la continua mejora de los procedimientos, servicios y prestaciones públicas, de acuerdo con las políticas que se dicten.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 6. Garantías que debe ofrecer la Administración Pública a las personas.",
                  style: subTituloFuente,
                ),
                Text(
                  "La Administración Pública desarrollará su actividad y se organizará de manera que las personas puedan:\n\n1. Resolver sus asuntos, ser auxiliadas en la redacción formal de documentos administrativos; y recibir información de su interés por cualquier medio escrito, oral, telefónico, electrónico e informático;\n\n2. Presentar reclamaciones sobre el funcionamiento de la Administración Pública;\n\n3. Acceder fácilmente a información actualizada sobre el esquema de organización de los órganos y entes de la Administración Pública, así como a guías informativas sobre los procedimientos administrativos, servicios y prestaciones que ellos ofrecen.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "3. LEY ORGÁNICA DE PROCEDIMIENTOS ADMINISTRATIVOS",
                    style: subTituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "G.O.R.V Nº 2.818 Extraordinaria de 1º de julio de 1981.",
                    style: normalTituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 3.",
                  style: subTituloFuente,
                ),
                Text(
                  "Los funcionarios y demás personas que presten servicios en la administración pública, están en la obligación de tramitar los asuntos cuyo conocimiento les corresponda y son responsables por las faltas en que incurran. \n\nLos interesados podrán reclamar, ante el superior jerárquico inmediato, del retardo, omisión, distorsión o incumplimiento de cualquier procedimiento, trámite o plazo, en que incurrieren los funcionarios responsables del asunto. \n\nEste reclamo deberá interponerse en forma escrita y razonada y será resuelto dentro de los quince (15) días siguientes. La reclamación no acarreará la paralización del procedimiento, ni obstaculizará la posibilidad de que sean subsanadas las fallas u omisiones. Si el superior jerárquico encontrare fundado el reclamo, impondrá al infractor o infractores la sanción prevista en el artículo 100 de la presente Ley sin perjuicio de las demás responsabilidades y sanciones a que hubiere lugar.\n\n",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "4. LEY ORGÁNICA DE LA CONTRALORÍA GENERAL DE LA REPÚBLICA.",
                    style: subTituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "G.O.R.B.V N° 6.013 Extraordinario del 23 de diciembre de 2010.",
                    style: normalTituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 25. Numeral 7",
                  style: subTituloFuente,
                ),
                Text(
                  "El Sistema Nacional de Control Fiscal se regirá por los siguientes principios:\n\n La participación de la ciudadanía en la gestión contralora.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Capítulo VIII De la participación ciudadana  \nArtículo 75.",
                  style: subTituloFuente,
                ),
                Text(
                  "El Contralor o Contralora General de la República, mediante resolución que se publicará en la Gaceta Oficial de la República Bolivariana de Venezuela, dictará las normas destinadas a fomentar la participación de los ciudadanos y ciudadanas, haciendo especial énfasis en los siguientes aspectos:\n\n…2. Ordenar, dirigir, sistematizar y evaluar las denuncias ciudadanas que provengan de las instancias que ejercen la contraloría social.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 96.",
                  style: subTituloFuente,
                ),
                Text(
                  "Si como consecuencia del ejercicio de las funciones de control o de las potestades investigativas establecidas en esta Ley, surgieren elementos de convicción o prueba que pudieran dar lugar a la formulación de reparos, a la declaratoria de responsabilidad administrativa o a la imposición de multas, el órgano de control fiscal respectivo iniciará el procedimiento mediante auto motivado que se notificará a los interesados o interesadas , según lo previsto en la Ley Orgánica de Procedimientos Administrativos.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "5. LEY DE INFOGOBIERNO",
                    style: subTituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "G.O.R.B.V Nº 37.313 30 de octubre de 2001 ",
                    style: normalTituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 8. Numeral 8. Derecho de las personas.",
                  style: subTituloFuente,
                ),
                Text(
                  "En las relaciones con el Poder Público y el Poder Popular, las personas tienen derecho a: \n\n …8. Disponer de mecanismos que permitan el ejercicio de la contraloría social haciendo uso de las tecnologías de información.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 14. Principio de accesibilidad.",
                  style: subTituloFuente,
                ),
                Text(
                  "El Poder Público, en forma corresponsable con el Poder Popular, participa en el desarrollo, implementación y uso de las tecnologías de información libres, a fin de garantizar a las personas, en igualdad de condiciones, el acceso y la apropiación social del conocimiento asociado a esas tecnologías.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 20. Derecho a la participación en la promoción de los servicios y uso de las tecnologías de información.",
                  style: subTituloFuente,
                ),
                Text(
                  "El Poder Público y el Poder Popular están obligados a garantizar en sus portales de internet el ejercicio del derecho de las personas a participar, colaborar y promover el uso de las tecnologías de información libres, creación de nuevos servicios electrónicos o mejoramiento de los ya existentes.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 21. Mecanismos de ejercicio de contraloría social.",
                  style: subTituloFuente,
                ),
                Text(
                  "Los servicios prestados por el Poder Público y el Poder Popular deben contener mecanismos que permitan la promoción, desarrollo y consolidación de la contraloría social como medio de participación de las personas y sus organizaciones sociales, para garantizar que la inversión pública se realice de manera transparente y eficiente, en beneficio de los intereses de la sociedad y que las actividades del sector privado no afecten los intereses colectivos o sociales.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "6. LEY DE SIMPLIFICACIÓN DE TRÁMITES ADMINISTRATIVOS.",
                    style: subTituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "G.O.R.B.V N° 40.549, de fecha 26 de noviembre de 2014",
                    style: normalTituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 36.",
                  style: subTituloFuente,
                ),
                Text(
                  "Las funcionarias o funcionarios públicos, las trabajadoras y trabajadores de la Administración Pública y, en general, quienes en cualquier situación de empleo público deban prestar un servicio a las personas con ocasión del cumplimiento de un trámite administrativo, serán considerados servidoras y servidores públicos a los fines del presente Decreto con Rango, Valor y Fuerza de Ley, obligados a procurar la mayor eficiencia y la más esmerada y amable atención a todas aquellas personas que realizan trámites ante la Administración Pública, en los cuales se requiera su concurso.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 38.",
                  style: subTituloFuente,
                ),
                Text(
                  "Los órganos y entes de la Administración Pública, tienen el deber de ofrecer a las personas información completa, oportuna y veraz en relación con los trámites que se realicen ante los mismos. La Administración Pública dará preferencia al uso de tecnologías de información, por medios de acceso remoto, a los fines de mantener informado al interesado sobre las resultas, el estado y demás notificaciones relacionados con el trámite de su interés. Los órganos y entes de la Administración Pública, deberán tener disponibles en sus sitios de Internet, vínculos que permitan a los interesados acceder a información sobre sus trámites. Adicionalmente, en las oficinas y establecimientos en los cuales se dé inicio a cualesquiera trámites administrativos, la máxima autoridad de dicha oficina o establecimiento será responsable de la fijación en sitio visible al público de los requisitos exigidos para cada trámite, las oficinas que intervienen y su ubicación, la identificación del funcionario responsable del trámite, su duración aproximada, los derechos de las personas en relación con el trámite o servicio en cuestión y la forma en que se pueden dirigir sus quejas, reclamos y sugerencias. Esta información se publicará además mediante guías simples de consulta pública, suministradas en forma gratuita, y deberá dárseles la publicidad necesaria a través de cualquier medio de comunicación, entre otros, visual, oral, escrito, informático o telemático.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 41. Servicio de atención al público. ",
                  style: subTituloFuente,
                ),
                Text(
                  "Cada uno de los órganos y entes de la Administración Pública deberá crear un servicio de atención al público, encargado de brindar toda la orientación y apoyo necesario a las personas en relación con los trámites que se realicen ante ellos, prestar servicios de recepción y entrega de documentos, solicitudes y requerimientos en general, así como recibir y procesar las denuncias, sugerencias y quejas que, en torno al servicio y a la actividad administrativa se formulen. Dichos servicios de atención al público estarán bajo la supervisión de la autoridad nacional unificada en materia de trámites administrativos, la cual podrá dictar regulaciones especiales sobre su funcionamiento, de obligatorio cumplimiento para todos los órganos y entes de la Administración Pública. Los órganos y entes de la Administración Pública, incluso de distintos Poderes Públicos o distintas entidades o unidades político territoriales, podrán suscribir encomiendas convenidas mediante las cuales acuerden la gestión conjunta de varios trámites, de manera parcial o total. En estas encomiendas convenidas podrán disponer el funcionamiento de varios organismos en una sola oficina, establecimiento, taquilla o ventanilla de atención, pudiendo establecer acuerdos especiales referidos al pago de determinados gastos de manera conjunta, indicando expresamente el porcentaje o la clase de gastos que corresponderá a cada órgano o ente.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "7. LEY PARA EL RESPETO DE LOS DERECHOS HUMANOS EN EL EJERCICIO DE LA FUNCIÓN PÚBLICA.",
                    style: subTituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "G.O.R.B.V N° 6.658 Extraordinario 28 de octubre de 2021",
                    style: normalTituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 1",
                  style: subTituloFuente,
                ),
                Text(
                  "Esta Ley tiene por objeto establecer los principios fundamentales y normas generales que permitan fortalecer el respeto, garantía y protección de los derechos humanos en el ejercicio de la función pública.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "8. LEY DE REFORMA DEL DECRETO CON RANGO, VALOR Y FUERZA DE LEY CONTRA LA CORRUPCIÓN.",
                    style: subTituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "G.O.R.B.V Nº N° 6.699 Extraordinario 2 de mayo de 2022",
                    style: normalTituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 86. Alardeamiento o valimiento de relaciones o influencias.",
                  style: subTituloFuente,
                ),
                Text(
                  "La persona que alardeando de valimiento o de relaciones de importancia e influencia con cualquier funcionaria pública o funcionario público reciba o se haga prometer, para sí o para otro, dinero o cualquier otra utilidad, bien como estímulo o recompensa de su mediación, bien so pretexto de remunerar el logro de favores, será penada o penado con prisión de dos (2) a siete (7) años; y con prisión de seis (6) meses a dos (2) años, a quien dé o prometa el dinero o cualquier otra utilidad de las que se indican en este artículo, a menos que haya denunciado el hecho ante la autoridad competente antes de la iniciación del correspondiente proceso judicial.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 89. Denuncia o acusación falsa",
                  style: subTituloFuente,
                ),
                Text(
                  "Cualquiera que falsamente denunciare o acusare a otra persona de la comisión de alguno o algunos de los hechos punibles previstos en esta Ley, será castigada con prisión de uno (1) a tres (3) años. ",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 90. Promesa de soborno a funcionaria pública o funcionario público.",
                  style: subTituloFuente,
                ),
                Text(
                  "Quien por sí o por persona interpuesta prometa, ofrezca u otorgue a una funcionaria pública o funcionario público de otro Estado, directa o indirectamente, por parte de sus nacionales, personas que tengan residencia habitual en su territorio y empresas domiciliadas en él, cualquier objeto de valor pecuniario u otros beneficios, como dádivas, favores, promesas, ventajas a cambio de que dicha funcionaria o funcionario realice u omita cualquier acto, en el ejercicio de sus funciones públicas, relacionado con una transacción de naturaleza económica, comercial o de cualquier otra índole, será penada o penado con prisión de seis (6) a doce (12) años.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "9. CÓDIGO DE CONDUCTA DE LOS SERVIDORES PÚBLICOS.",
                    style: subTituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "G.O.R.B.V Nº N° 6.699 Extraordinario 2 de mayo de 2022",
                    style: normalTituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "TÍTULO II PRINCIPIOS ÉTICOS DEL SERVIDOR PÚBLICO\n\nArtículo 3.",
                  style: subTituloFuente,
                ),
                Text(
                  "A los efectos de este Código son principios rectores de los deberes y conductas de los servidores públicos respecto a los valores éticos que han de regir la función pública: a) La honestidad. b) La equidad. c) El decoro. d) La lealtad. e) La vocación de servicio. f) La disciplina. g) La eficacia. h) La responsabilidad. i) La puntualidad. j) La transparencia k) La pulcritud.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "10. CÓDIGO DE ÉTICA PARA EL FUNCIONARIO PÚBLICO",
                    style: subTituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "G.O.R.V Nº 36.268 del miércoles 13 de agosto de 1997",
                    style: normalTituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 1. Corresponde a los funcionarios públicos: ",
                  style: subTituloFuente,
                ),
                Text(
                  "Salvaguardar en todo momento y en cada una de sus actuaciones, los intereses generales del Estado y en la preservación del patrimonio público. 2. Actuar con estricto apego a las leyes y a todas las demás normas e instrucciones que deben regir su comportamiento en la realización cabal de todas las tareas que tenga asignadas. 3. Dedicar todos sus esfuerzos para cumplir, con la máxima eficiencia y la más alta \n eficacia, la misión que le esté encomendada. 4. Realizar permanentemente actividades de superación personal y de colaboración en el mejoramiento institucional de la administración pública y, en particular, del organismo donde preste sus servicios. 5. Rehusar con firmeza inequívoca el mantenimiento de relaciones o de intereses, con personas u organizaciones, que sean incompatibles con sus cargos y con las atribuciones y funciones que le estén asignadas. 6. Proceder con objetividad e imparcialidad en todas las decisiones que le corresponda tomar y en los asuntos en los que deba intervenir. 7. Rechazar en cualquier caso y circunstancia y no solicitar jamás, ni para sí mismos ni para terceros, pagos, beneficios o privilegios en ocasión de los servicios que deba prestar. 8. Ajustar su conducta, de modo estricto y sin excepciones, a favor de la transparencia en la administración pública manteniendo la confidencialidad y reserva de información en aquellos casos excepcionales cuya divulgación esté prohibida, por razones del superior interés público, de modo expreso y temporal. 9. Denunciar ante la autoridad competente y rechazar cualquier actividad contraria al correcto manejo de los fondos y del interés público. 10. Tratar a los ciudadanos y a los funcionarios públicos con absoluto respeto y con apego a la estricta legalidad, prestándole sus servicios y colaboración de manera eficiente, puntual y pertinente, sin abusar en modo alguno de la autoridad y atribuciones que le sean conferidas en ocasión del cargo que desempeñe.",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "11. DECRETO SOBRE ORGANIZACIÓN GENERAL \n DE LA ADMINISTRACIÓN PÚBLICA NACIONAL",
                    style: subTituloFuente,
                  ),
                ),
                Center(
                  child: Text(
                    "Decreto N° 2.378. G.O.R.B.V N° 6.238 Extraordinario del 13 de julio de 2016",
                    style: normalTituloFuente,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Artículo 22. Las Oficinas de Atención Ciudadana",
                  style: subTituloFuente,
                ),
                Text(
                  "…1. Asesorar y atender a los ciudadanos, ciudadanas y comunidades organizadas que acudan a la Oficina a interponer denuncias, quejas, reclamos, sugerencias o peticiones, en relación a los trámites y servicios que presta el Ministerio, en articulación con las unidades o dependencias administrativas u órganos públicos o entidades privadas con competencia en la materia, según sea el caso. …5. Gestionar y hacer seguimiento a las atenciones dadas en esta Oficina, así como emitir información oportuna sobre el estado o curso de la solicitud o trámite interpuesto y el plazo dentro del cual se dará respuesta. …7. Participar en las actividades relativas a la atención de la ciudadanía",
                  style: normalTituloFuente,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ]),
      ],
    );
  }
}
