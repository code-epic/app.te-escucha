import 'package:flutter/material.dart';
import 'package:te_escucha/src/model/const.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:te_escucha/src/gui/home.dart';

const MarkDownText = """
#### **BASES LEGALES PARA EL SISTEMA DE ATENCIÓN AL CIUDADANO**
---

#### **1. CONSTITUCIÓN DE LA REPÚBLICA BOLIVARIANA DE VENEZUELA.**
##### **G.O.R.B.V N° 36.860 de fecha 30 de diciembre de 1.999.**\n

**Capítulo III. De los Derechos Civiles**\n
**_Artículo 51._**
Toda persona tiene el derecho de representar o dirigir peticiones ante cualquier
autoridad, funcionario público o funcionaria pública sobre los asuntos que sean de
la competencia de éstos o éstas, y de obtener oportuna y adecuada respuesta.
Quienes violen este derecho serán sancionados o sancionadas conforme a la ley,
pudiendo ser destituidos o destituidas del cargo respectivo.\n

#### **TÍTULO IV. DEL PODER PÚBLICO**
**Capítulo I. Sección Segunda: De la Administración Pública**\n
**_Artículo 141._**\n
La Administración Pública está al servicio de los ciudadanos y ciudadanas y se
fundamenta en los principios de honestidad, participación, celeridad, eficacia,
eficiencia, transparencia, rendición de cuentas y responsabilidad en el ejercicio de
la función pública, con sometimiento pleno a la ley y al derecho.

#### **2. LEY ORGÁNICA DE LA ADMINISTRACIÓN PÚBLICA.**
##### **G.O.R.B.V N° 37.305 de fecha 17 de octubre de 2001.**

**_Artículo 3. Objetivo de la Administración Pública_**\n
La Administración Pública tendrá como objetivo de su organización y
funcionamiento hacer efectivos los principios, valores y normas consagrados en la
Constitución de la República Bolivariana de Venezuela y en especial, garantizar a
todas las personas, el goce y ejercicio de los derechos humanos.\n

**_Artículo 5. Principio de la Administración Pública al servicio de las personas_**\n
La Administración Pública está al servicio de las personas, y su actuación estará
dirigida a la atención de sus requerimientos y la satisfacción de sus necesidades,
brindando especial atención a las de carácter social.\n

La Administración Pública debe asegurar a todas las personas la efectividad de
sus derechos cuando se relacionen con ella.\n

Además, tendrá entre sus objetivos la continua mejora de los procedimientos,
servicios y prestaciones públicas, de acuerdo con las políticas que se dicten.\n

**_Artículo 6. Garantías que debe ofrecer la Administración Pública a las
personas._**\n
La Administración Pública desarrollará su actividad y se organizará de manera que
las personas puedan:\n
1. Resolver sus asuntos, ser auxiliadas en la redacción formal de documentos
administrativos; y recibir información de su interés por cualquier medio escrito,
oral, telefónico, electrónico e informático;
2. Presentar reclamaciones sobre el funcionamiento de la Administración Pública;
3. Acceder fácilmente a información actualizada sobre el esquema de organización
de los órganos y entes de la Administración Pública, así como a guías informativas
sobre los procedimientos administrativos, servicios y prestaciones que ellos
ofrecen.\n

#### **3. LEY ORGÁNICA DE PROCEDIMIENTOS ADMINISTRATIVOS**
##### **G.O.R.V Nº 2.818 Extraordinaria de 1º de julio de 1981.**

**_Artículo 3._**
Los funcionarios y demás personas que presten servicios en la administración
pública, están en la obligación de tramitar los asuntos cuyo conocimiento les
corresponda y son responsables por las faltas en que incurran.\n
Los interesados podrán reclamar, ante el superior jerárquico inmediato, del
retardo, omisión, distorsión o incumplimiento de cualquier procedimiento, trámite o
plazo, en que incurrieren los funcionarios responsables del asunto.\n
Este reclamo deberá interponerse en forma escrita y razonada y será resuelto
dentro de los quince (15) días siguientes. La reclamación no acarreará la
paralización del procedimiento, ni obstaculizará la posibilidad de que sean
subsanadas las fallas u omisiones. Si el superior jerárquico encontrare fundado el
reclamo, impondrá al infractor o infractores la sanción prevista en el artículo 100
de la presente Ley sin perjuicio de las demás responsabilidades y sanciones a que
hubiere lugar.\n

#### **4. LEY ORGÁNICA DE LA CONTRALORÍA GENERAL DE LA REPÚBLICA.**
##### **G.O.R.B.V N° 6.013 Extraordinario del 23 de diciembre de 2010.**

**_Artículo 25. Numeral 7_**
El Sistema Nacional de Control Fiscal se regirá por los siguientes principios:
…7. La participación de la ciudadanía en la gestión contralora.


**Capítulo VIII De la participación ciudadana**
**_Artículo 75._**
El Contralor o Contralora General de la República, mediante resolución que se
publicará en la Gaceta Oficial de la República Bolivariana de Venezuela, dictará
las normas destinadas a fomentar la participación de los ciudadanos y ciudadanas,
haciendo especial énfasis en los siguientes aspectos:\n
…2. Ordenar, dirigir, sistematizar y evaluar las denuncias ciudadanas que
provengan de las instancias que ejercen la contraloría social.\n

**_Artículo 96._**
Si como consecuencia del ejercicio de las funciones de control o de las potestades
investigativas establecidas en esta Ley, surgieren elementos de convicción o
prueba que pudieran dar lugar a la formulación de reparos, a la declaratoria de
responsabilidad administrativa o a la imposición de multas, el órgano de control
fiscal respectivo iniciará el procedimiento mediante auto motivado que se notificará
a los interesados o interesadas , según lo previsto en la Ley Orgánica de
Procedimientos Administrativos.

#### **5. LEY DE INFOGOBIERNO**
##### **G.O.R.B.V Nº 37.313 30 de octubre de 2001**

**_Artículo 8. Numeral 8. Derecho de las personas._**
En las relaciones con el Poder Público y el Poder Popular, las personas tienen
derecho a:\n
…8. Disponer de mecanismos que permitan el ejercicio de la contraloría social
haciendo uso de las tecnologías de información.

**_Artículo 14. Principio de accesibilidad_**\n
El Poder Público, en forma corresponsable con el Poder Popular, participa en el
desarrollo, implementación y uso de las tecnologías de información libres, a fin de
garantizar a las personas, en igualdad de condiciones, el acceso y la apropiación
social del conocimiento asociado a esas tecnologías.

**_Artículo 20. Derecho a la participación en la promoción de los servicios y
uso de las tecnologías de información._**
El Poder Público y el Poder Popular están obligados a garantizar en sus portales
de internet el ejercicio del derecho de las personas a participar, colaborar y
promover el uso de las tecnologías de información libres, creación de nuevos
servicios electrónicos o mejoramiento de los ya existentes.

**_Artículo 21. Mecanismos de ejercicio de contraloría social._**
Los servicios prestados por el Poder Público y el Poder Popular deben contener
mecanismos que permitan la promoción, desarrollo y consolidación de la
contraloría social como medio de participación de las personas y sus
organizaciones sociales, para garantizar que la inversión pública se realice de
manera transparente y eficiente, en beneficio de los intereses de la sociedad y que
las actividades del sector privado no afecten los intereses colectivos o sociales.

#### **6. LEY DE SIMPLIFICACIÓN DE TRÁMITES ADMINISTRATIVOS.**
##### **G.O.R.B.V N° 40.549, de fecha 26 de noviembre de 2014**

**_Artículo 36._**\n
Las funcionarias o funcionarios públicos, las trabajadoras y trabajadores de la
Administración Pública y, en general, quienes en cualquier situación de empleo
público deban prestar un servicio a las personas con ocasión del cumplimiento de
un trámite administrativo, serán considerados servidoras y servidores públicos a
los fines del presente Decreto con Rango, Valor y Fuerza de Ley, obligados a
procurar la mayor eficiencia y la más esmerada y amable atención a todas
aquellas personas que realizan trámites ante la Administración Pública, en los
cuales se requiera su concurso.

**_Artículo 38._**\n
Los órganos y entes de la Administración Pública, tienen el deber de ofrecer a las
personas información completa, oportuna y veraz en relación con los trámites que
se realicen ante los mismos. La Administración Pública dará preferencia al uso de
tecnologías de información, por medios de acceso remoto, a los fines de mantener
informado al interesado sobre las resultas, el estado y demás notificaciones
relacionados con el trámite de su interés. Los órganos y entes de la Administración
Pública, deberán tener disponibles en sus sitios de Internet, vínculos que permitan
a los interesados acceder a información sobre sus trámites. Adicionalmente, en las
oficinas y establecimientos en los cuales se dé inicio a cualesquiera trámites
administrativos, la máxima autoridad de dicha oficina o establecimiento será
responsable de la fijación en sitio visible al público de los requisitos exigidos para
cada trámite, las oficinas que intervienen y su ubicación, la identificación del
funcionario responsable del trámite, su duración aproximada, los derechos de las
personas en relación con el trámite o servicio en cuestión y la forma en que se
pueden dirigir sus quejas, reclamos y sugerencias. Esta información se publicará
además mediante guías simples de consulta pública, suministradas en forma
gratuita, y deberá dárseles la publicidad necesaria a través de cualquier medio de
comunicación, entre otros, visual, oral, escrito, informático o telemático.

**_Artículo 41. Servicio de atención al público._**\n
Cada uno de los órganos y entes de la Administración Pública deberá crear un
servicio de atención al público, encargado de brindar toda la orientación y apoyo
necesario a las personas en relación con los trámites que se realicen ante ellos,
prestar servicios de recepción y entrega de documentos, solicitudes y
requerimientos en general, así como recibir y procesar las denuncias, sugerencias
y quejas que, en torno al servicio y a la actividad administrativa se formulen.
Dichos servicios de atención al público estarán bajo la supervisión de la autoridad
nacional unificada en materia de trámites administrativos, la cual podrá dictar
regulaciones especiales sobre su funcionamiento, de obligatorio cumplimiento
para todos los órganos y entes de la Administración Pública. Los órganos y entes
de la Administración Pública, incluso de distintos Poderes Públicos o distintas
entidades o unidades político territoriales, podrán suscribir encomiendas
convenidas mediante las cuales acuerden la gestión conjunta de varios trámites,
de manera parcial o total. En estas encomiendas convenidas podrán disponer el
funcionamiento de varios organismos en una sola oficina, establecimiento, taquilla
o ventanilla de atención, pudiendo establecer acuerdos especiales referidos al
pago de determinados gastos de manera conjunta, indicando expresamente el
porcentaje o la clase de gastos que corresponderá a cada órgano o ente.

#### **7. LEY PARA EL RESPETO DE LOS DERECHOS HUMANOS EN EL EJERCICIO DE LA FUNCIÓN PÚBLICA.**
##### **G.O.R.B.V N° 6.658 Extraordinario 28 de octubre de 2021**

**_Artículo 1._**\n 
Esta Ley tiene por objeto establecer los principios fundamentales y
normas generales que permitan fortalecer el respeto, garantía y protección de los
derechos humanos en el ejercicio de la función pública.\n

#### **8. LEY DE REFORMA DEL DECRETO CON RANGO, VALOR Y FUERZA DE LEY CONTRA LA CORRUPCIÓN.**
##### **G.O.R.B.V Nº N° 6.699 Extraordinario 2 de mayo de 2022**

**_Artículo 86. Alardeamiento o valimiento de relaciones o influencias._**\n
La persona que alardeando de valimiento o de relaciones de importancia e
influencia con cualquier funcionaria pública o funcionario público reciba o se haga
prometer, para sí o para otro, dinero o cualquier otra utilidad, bien como estímulo o
recompensa de su mediación, bien so pretexto de remunerar el logro de favores,
será penada o penado con prisión de dos (2) a siete (7) años; y con prisión de seis
(6) meses a dos (2) años, a quien dé o prometa el dinero o cualquier otra utilidad
de las que se indican en este artículo, a menos que haya denunciado el hecho
ante la autoridad competente antes de la iniciación del correspondiente proceso
judicial.\n

**_Artículo 89. Denuncia o acusación falsa_**\n
Cualquiera que falsamente denunciare o acusare a otra persona de la comisión de
alguno o algunos de los hechos punibles previstos en esta Ley, será castigada con
prisión de uno (1) a tres (3) años.\n

**_Artículo 90. Promesa de soborno a funcionaria pública o funcionario público._**\n
Quien por sí o por persona interpuesta prometa, ofrezca u otorgue a una
funcionaria pública o funcionario público de otro Estado, directa o indirectamente,
por parte de sus nacionales, personas que tengan residencia habitual en su
territorio y empresas domiciliadas en él, cualquier objeto de valor pecuniario u
otros beneficios, como dádivas, favores, promesas, ventajas a cambio de que
dicha funcionaria o funcionario realice u omita cualquier acto, en el ejercicio de sus
funciones públicas, relacionado con una transacción de naturaleza económica,
comercial o de cualquier otra índole, será penada o penado con prisión de seis (6)
a doce (12) años.\n

#### **9. CÓDIGO DE CONDUCTA DE LOS SERVIDORES PÚBLICOS.**
##### **G.O.R.V N° 36.496 de fecha 15 de julio de 1998**


**TÍTULO II PRINCIPIOS ÉTICOS DEL SERVIDOR PÚBLICO**\n
**_Artículo 3._**\n
A los efectos de este Código son principios rectores de los deberes y conductas
de los servidores públicos respecto a los valores éticos que han de regir la función
pública: a) La honestidad. b) La equidad. c) El decoro. d) La lealtad. e) La
vocación de servicio. f) La disciplina. g) La eficacia. h) La responsabilidad. i) La
puntualidad. j) La transparencia k) La pulcritud.


#### **10. CÓDIGO DE ÉTICA PARA EL FUNCIONARIO PÚBLICO**
##### **G.O.R.V Nº 36.268 del miércoles 13 de agosto de 1997**

**_Artículo 1._**\n
Corresponde a los funcionarios públicos:\n
1. Salvaguardar en todo momento y en cada una de sus actuaciones, los intereses
generales del Estado y en la preservación del patrimonio público.
2. Actuar con estricto apego a las leyes y a todas las demás normas e
instrucciones que deben regir su comportamiento en la realización cabal de todas
las tareas que tenga asignadas.
3. Dedicar todos sus esfuerzos para cumplir, con la máxima eficiencia y la más
alta
eficacia, la misión que le esté encomendada.
4. Realizar permanentemente actividades de superación personal y de
colaboración en el mejoramiento institucional de la administración pública y, en
particular, del organismo donde preste sus servicios.
5. Rehusar con firmeza inequívoca el mantenimiento de relaciones o de intereses,
con personas u organizaciones, que sean incompatibles con sus cargos y con las
atribuciones y funciones que le estén asignadas.
6. Proceder con objetividad e imparcialidad en todas las decisiones que le
corresponda tomar y en los asuntos en los que deba intervenir.
7. Rechazar en cualquier caso y circunstancia y no solicitar jamás, ni para sí
mismos ni para terceros, pagos, beneficios o privilegios en ocasión de los servicios
que deba prestar.
8. Ajustar su conducta, de modo estricto y sin excepciones, a favor de la
transparencia en la administración pública manteniendo la confidencialidad y
reserva de información en aquellos casos excepcionales cuya divulgación esté
prohibida, por razones del superior interés público, de modo expreso y temporal.
9. Denunciar ante la autoridad competente y rechazar cualquier actividad contraria
al correcto manejo de los fondos y del interés público.
10. Tratar a los ciudadanos y a los funcionarios públicos con absoluto respeto y
con apego a la estricta legalidad, prestándole sus servicios y colaboración de
manera eficiente, puntual y pertinente, sin abusar en modo alguno de la autoridad
y atribuciones que le sean conferidas en ocasión del cargo que desempeñe.

#### **11. DECRETO SOBRE ORGANIZACIÓN GENERAL DE LA ADMINISTRACIÓN PÚBLICA NACIONAL Decreto N° 2.378.**
##### **G.O.R.B.V N° 6.238 Extraordinario del 13 de julio de 2016**

**_Artículo 22. Las Oficinas de Atención Ciudadana_**\n

…1. Asesorar y atender a los ciudadanos, ciudadanas y comunidades organizadas
que acudan a la Oficina a interponer denuncias, quejas, reclamos, sugerencias o
peticiones, en relación a los trámites y servicios que presta el Ministerio, en
articulación con las unidades o dependencias administrativas u órganos públicos o
entidades privadas con competencia en la materia, según sea el caso.\n

…5. Gestionar y hacer seguimiento a las atenciones dadas en esta Oficina, así
como emitir información oportuna sobre el estado o curso de la solicitud o trámite
interpuesto y el plazo dentro del cual se dará respuesta.\n

…7. Participar en las actividades relativas a la atención de la ciudadanía

#### **12. NORMAS PARA FOMENTAR LA PARTICIPACIÓN CIUDADANA**
##### **G.O.R.V N° 38.750 de fecha 20 de agosto de 2007**

**_Artículo 5._**\n
Principios y valores que regulan la participación ciudadana
La participación de los ciudadanos en el ejercicio del control sobre la gestión
pública, se regirá por los principios de corresponsabilidad, rendición de cuentas,
honestidad, eficiencia y eficacia, sobre la base de los valores de la vida, la libertad,
la igualdad, la justicia, la paz, la solidaridad, el bien común, el imperio de la Ley, la
ética, el pluralismo político y la preeminencia de los derechos humanos.

**_Artículo 9._**\n
Interposición de denuncias, quejas, reclamos, sugerencias o peticiones
Los ciudadanos de forma individual o colectiva, directamente o por medio de sus
representantes elegidos, o a través de la comunidad organizada, podrán presentar
ante la Oficina de Atención Ciudadana denuncias, quejas, reclamos, sugerencias o
peticiones.

**_Artículo 10._**\n
El servicio de atención a la ciudadanía se prestará, fundamentalmente, por la
Oficina de Atención Ciudadana, que de conformidad con lo previsto en el artículo 9
de la Ley Contra la Corrupción deben crear los organismos y entidades a que se
refieren los numerales 1 al 11 del artículo 9 de la Ley Orgánica de la Contraloría
General de la República y del Sistema Nacional de Control Fiscal.\n

**_Artículo 12._**\n
El objetivo de la Oficina de Atención Ciudadana es promover la participación
ciudadana; suministrar y ofrecer de forma oportuna, adecuada y efectiva, la
información requerida; apoyar, orientar, recibir y tramitar denuncias, quejas,
reclamos, sugerencias y peticiones; y en general, resolver las solicitudes
formuladas por los ciudadanos.\n

**_Artículo 13._**\n
Las máximas autoridades jerárquicas de los organismos y entidades a que se
refieren los numerales 1 al 11 del artículo 9 de la Ley Orgánica de la Contraloría
General de la República y del Sistema Nacional de Control Fiscal, establecerán las
funciones de la Oficina de Atención Ciudadana, de conformidad con el
ordenamiento jurídico que los regula y las presentes Normas.\n
A las Oficinas de Atención Ciudadana les corresponderá, fundamentalmente:
1. Atender, orientar, apoyar y asesorar a los ciudadanos que acudan a solicitar
información, requerir documentos o interponer denuncias, quejas, reclamos,
sugerencias o peticiones.
2. Informar a la ciudadanía sobre la utilización de los recursos que integran el
patrimonio público del ente u organismo, a través de un informe, de fácil manejo y
comprensión, que se publicará trimestralmente y se pondrá a disposición de
cualquier persona.
3. Poner a disposición de la ciudadanía la información relativa a la estructura
organizativa y funciones del respectivo ente u organismo y de sus órganos
adscritos, y sobre los procedimientos administrativos y servicios que presta, a
través de medios impresos, audiovisuales, informáticos, entre otros.
4. Recibir, tramitar, valorar, decidir o resolver, denuncias, quejas, reclamos,
sugerencias o peticiones y remitirlas a la dependencia de la organización o al ente
u organismo que tenga competencia para conocerlas, según el caso.
5. Llevar un registro automatizado de las denuncias, quejas, reclamos,
sugerencias y peticiones.
6. Comunicar a los ciudadanos la decisión o respuesta de las denuncias, quejas,
reclamos, sugerencias y peticiones formuladas por ellos.
7. Promover la participación ciudadana.
8. Llevar el registro de las comunidades organizadas y de las organizaciones
públicas no estatales a que hace mención el artículo 135 de la Ley Orgánica de la
Administración Pública.
9. Formar y capacitar a la comunidad en los aspectos vinculados con el ejercicio
del derecho a la participación ciudadana en el control de la gestión pública
mediante talleres, foros o seminarios, entre otros.
10. Atender las iniciativas de la comunidad vinculadas con el ejercicio de la
participación ciudadana en el control de la gestión pública.
11. Las demás competencias que le sean asignadas.

**Sección II.**\n
**De la Tramitación de las Denuncias, Quejas, Reclamos, Sugerencias y
Peticiones.**\n
**_Artículo 15._**\n

La Oficina de Atención Ciudadana determinará si el organismo o entidad tiene
competencia para tramitar la denuncia, la queja, reclamo, sugerencia o petición
presentada.\n

En caso de determinar que el organismo o entidad es competente para resolver la
denuncia, queja, reclamo, sugerencia o petición, indicará al ciudadano que su
solicitud se tramitará en la organización y que se le informará sobre las resultas.
En caso de determinar que el organismo o entidad no es competente para resolver
la denuncia, queja, reclamo, sugerencia o petición, la remitirá al órgano o entidad
competente e informará al ciudadano sobre dicha remisión.\n

De la normativa transcrita tenemos que los términos aplicables a los efectos del
sistema a aplicar son Denuncias, Quejas, Reclamos, Sugerencias y Peticiones.\n

**1. DENUNCIA 1** : Vinculadas con la comisión de actos, hechos u omisiones
1 Normas para Fomentar la Participación Ciudadana, artículos 17 y 20
contrarios a una disposición legal o sublegal relacionados con la
administración, manejo o custodia de fondos o bienes públicos, la Oficina
de Atención Ciudadana las remitirá al órgano de control fiscal competente,
para que ejerza las acciones fiscales. Asimismo, informara a la autoridad a
quien corresponda adoptar las medidas inmediatas tendentes a impedir o
corregir las deficiencias denunciadas o la producción de daño al patrimonio
público, de ser el caso, preservado en todo momento la identidad del
denunciante.
Las denuncias podrán formularse por escrito, firmadas en original;
verbalmente o a través de medios electrónicos y deberán contener la
identificación del denunciante, la narración circunstanciada de los actos,
hechos u omisiones presuntamente irregulares, el señalamiento de quienes
lo han cometido, fecha de ocurrencia, ente u organismo donde ocurrieron y
todo cuanto le constare el denunciante.\n

**2. QUEJA 2** : Es una articulación que puede tener o no contenido jurídico y
puede recaer sobre los servicios administrativos prestados por el sector
público o sobre los servicios públicos prestados por personas públicas o
privadas, ambas modalidades en defensa de los derechos, garantías e
intereses de quienes las interponen.\n

**3. RECLAMO 3**: Denota una inconformidad que una persona tiene con una
situación concreta, por lo general en el marco de un procedimiento
administrativo. Se trata de dirigirse a una autoridad administrativa o judicial
para que ésta reconozca un derecho.\n

**4. SUGERENCIA**: Acto de proponer, recomendar, una idea o propuesta para
mejorar la prestación de un servicio en la entidad.

**5. PETICIÓN 4**: Se trata del escrito que se presenta ante una autoridad
competente formulando una determinada solicitud o requerimiento. 
""";

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
