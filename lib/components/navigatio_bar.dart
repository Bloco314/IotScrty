import 'package:flutter/material.dart';
import 'package:iot_scrty/pages/_cad_environment.dart';
import 'package:iot_scrty/pages/_cad_equip.dart';
import 'package:iot_scrty/pages/_horarios_professor.dart';
import 'package:iot_scrty/pages/_register_loan.dart';
import 'package:iot_scrty/pages/_solicitations.dart';

class NavBarProfessor extends StatelessWidget {
  final String nome;
  final String email;
  final BuildContext cont;

  NavBarProfessor(
      {required this.nome, required this.email, required this.cont});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(cont).size.width * 50 / 100,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //cabeçalho
          UserAccountsDrawerHeader(
            accountName: Text(nome),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
                child: ClipOval(
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Braz%C3%A3o_UEA.jpg/300px-Braz%C3%A3o_UEA.jpg",
                width: 100,
                height: 100,
              ),
            )),
            decoration: const BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://imgs.search.brave.com/ybYeaAEnZLyWPPSCbokEc8qen6-wUyLCWfgUJuUNktI/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9mYXN0/bHkuNHNxaS5uZXQv/aW1nL2dlbmVyYWwv/NjAweDYwMC9USEpS/U0xKSVdXSEtYTFVB/QUY0REgyQk9YWEVJ/TEZBV1ZLMTExWDJI/TFRaVTFIRTEuanBn"),
                    fit: BoxFit.cover)),
          ),
          //itens da navbar
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Emprestimo aluno'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckinEquip()))
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_searching),
            title: const Text('Solicitações'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Solicitacoes()))
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit_calendar),
            title: const Text('Horarios'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Horarios()))
            },
          ),
          const Divider()
        ],
      ),
    );
  }
}

class NavBarCoordenador extends StatelessWidget {
  final String nome;
  final String email;
  final BuildContext cont;

  NavBarCoordenador(
      {required this.nome, required this.email, required this.cont});

  void tela_equipamentos(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadEquip(
                  email: email,
                  nome: nome,
                )));
  }

  void tela_ambientes(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewEnvironments(
                  email: email,
                  nome: nome,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(cont).size.width * 50 / 100,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //cabeçalho
          UserAccountsDrawerHeader(
            accountName: Text(nome),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
                child: ClipOval(
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Braz%C3%A3o_UEA.jpg/300px-Braz%C3%A3o_UEA.jpg",
                width: 100,
                height: 100,
              ),
            )),
            decoration: const BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://imgs.search.brave.com/ybYeaAEnZLyWPPSCbokEc8qen6-wUyLCWfgUJuUNktI/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9mYXN0/bHkuNHNxaS5uZXQv/aW1nL2dlbmVyYWwv/NjAweDYwMC9USEpS/U0xKSVdXSEtYTFVB/QUY0REgyQk9YWEVJ/TEZBV1ZLMTExWDJI/TFRaVTFIRTEuanBn"),
                    fit: BoxFit.cover)),
          ),
          //itens da navbar
          ListTile(
            leading: const Icon(Icons.apartment_sharp),
            title: const Text('Ambientes'),
            onTap: () => tela_ambientes(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.computer),
            title: const Text('Equipamentos'),
            onTap: () => tela_equipamentos(context),
          ),
          const Divider()
        ],
      ),
    );
  }
}
