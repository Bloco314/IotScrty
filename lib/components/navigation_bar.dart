import 'package:flutter/material.dart';
import 'package:iot_scrty/pages/_horarios_professor.dart';
import 'package:iot_scrty/pages/_registrar_emprestimo.dart';
import 'package:iot_scrty/pages/_solicitations.dart';

class NavBarProfessor extends StatelessWidget {
  final String nome;
  final String email;

  NavBarProfessor({required this.nome, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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

  NavBarCoordenador({required this.nome, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            title: const Text('blabla'),
            onTap: () => null,
          ),
          const Divider()
        ],
      ),
    );
  }
}
