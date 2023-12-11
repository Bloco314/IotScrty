import 'package:flutter/material.dart';
import 'package:iot_scrty/pages/_environment.dart';
import 'package:iot_scrty/pages/_equipments.dart';
import 'package:iot_scrty/pages/_home_coordenador.dart';
import 'package:iot_scrty/pages/_home_professor.dart';
import 'package:iot_scrty/pages/_horarios_professor.dart';
import 'package:iot_scrty/pages/_register_loan.dart';
import 'package:iot_scrty/pages/_solicitations.dart';

class NavBarProfessor extends StatelessWidget {
  final String nome;
  final String email;
  final BuildContext cont;
  final String pageName;

  NavBarProfessor(
      {required this.nome,
      required this.email,
      required this.cont,
      required this.pageName});

  void navigateTo(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
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
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => {
                    if (pageName != 'professor_home')
                      {
                        navigateTo(
                            context, HomePState(email: email, nome: nome))
                      }
                  }),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Emprestimo aluno'),
            onTap: () => navigateTo(context, CheckinEquip()),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_searching),
            title: const Text('Solicitações'),
            onTap: () =>
                navigateTo(context, Solicitacoes(nome: nome, email: email)),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit_calendar),
            title: const Text('Horarios'),
            onTap: () => navigateTo(context, Horarios()),
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
  final String pageName;

  NavBarCoordenador(
      {required this.nome,
      required this.email,
      required this.cont,
      required this.pageName});

  void navigateTo(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  double navBarSize (){
    double width = MediaQuery.of(cont).size.width; 
    if (width >= 600){
      return width * 35 / 100;
    }
      return width * 55 / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: navBarSize(),
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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => {
              if (pageName != 'coordenador_home')
                {navigateTo(context, HomeCState(email: email, nome: nome))}
              else
                {Navigator.of(context).pop()}
            },
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.apartment_rounded),
              title: const Text('Ambientes'),
              onTap: () => {
                    if (pageName != 'visualizar_ambientes')
                      {
                        navigateTo(
                            context, ViewEnvironments(nome: nome, email: email))
                      }
                    else
                      {Navigator.of(context).pop()}
                  }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.computer),
              title: const Text('Equipamentos'),
              onTap: () => {
                    if (pageName != 'cadastrar_equipamentos')
                      {navigateTo(context, CadEquip(nome: nome, email: email))}
                    else
                      {Navigator.of(context).pop()}
                  }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.wechat),
              title: const Text('Solicitações'),
              onTap: () => {
                    if (pageName != 'solicitacoes')
                      {
                        navigateTo(
                            context, Solicitacoes(nome: nome, email: email))
                      }
                    else
                      {Navigator.of(context).pop()}
                  }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.exit_to_app_sharp),
              title: const Text('Logout'),
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/', (route) => false)),
          const Divider()
        ],
      ),
    );
  }
}
