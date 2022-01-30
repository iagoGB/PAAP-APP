import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "PAAP-Móvel Versão 1.0",
                style: customStyle(),
              ),
            ),
          ],
        )
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Sobre o PAAP",
              style: TextStyle(fontSize: 18),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 9),
            ),
            Text(
              "É o Programa de Formação para a Docência no Ensino Superior da Universidade Federal do Ceará (UFC), denominado de Programa de Apoio e Acompanhamento Pedagógico (PAAP) da Coordenadoria de Inovação e Desenvolvimento Acadêmico (COIDEA), vinculada à Escola Integrada de Desenvolvimento e Inovação Acadêmica (EIDEIA). Atua em parceria com a Pró-Reitoria de Graduação (PROGRAD) e com a Pró-Reitoria de Gestão de Pessoas(PROGEP), pois compreende que é importante um trabalho que vise  a  integração de professores, técnicos e estudantes, considerados a tríade humana, que dá sustentabilidade à Universidade.",
              textAlign: TextAlign.justify,
              style: customStyle(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
            ),
            Text(
              "Sobre o PAAP Móvel",
              style: TextStyle(fontSize: 18),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 9),
            ),
            Text(
              "Com esse aplicativo pretendemos otimizar o acesso, a participação, a interatividade e a certificação de todo público docente, que venha participar das atividades formativas.",
              textAlign: TextAlign.justify,
              style: customStyle(),
            ),
          ]),
        ),
      ),
    );
  }

  customStyle() {
    return TextStyle(color: Colors.grey.shade500);
  }
}
