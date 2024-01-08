import 'package:flutter/material.dart';
import 'package:iot_scrty/pages/_environment.dart';
import 'package:iot_scrty/pages/_equipments.dart';
import 'package:iot_scrty/pages/_home_page.dart';
import 'package:iot_scrty/pages/_horarios_professor.dart';
import 'package:iot_scrty/pages/_register_loan.dart';
import 'package:iot_scrty/pages/_solicitations.dart';

abstract class NavBase extends StatelessWidget {
  final String nome;
  final String email;
  final BuildContext cont;
  final String pageName;

  void navigateTo(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  double navBarSize() {
    double width = MediaQuery.of(cont).size.width;
    if (width >= 600) {
      return width * 35 / 100;
    }
    return width * 55 / 100;
  }

  NavBase(
      {required this.nome,
      required this.email,
      required this.cont,
      required this.pageName});
}

class NavBarProfessor extends NavBase {
  NavBarProfessor(
      {required String nome,
      required String email,
      required BuildContext cont,
      required String pageName})
      : super(nome: nome, email: email, cont: cont, pageName: pageName);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: navBarSize(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //cabeçalho
          const UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text(''),
            currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/assets/guest.png')),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    image: AssetImage('lib/assets/ueaLogo.jpg'),
                    fit: BoxFit.cover)),
          ),
          //itens da navbar
          ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () => {
                    if (pageName != 'professor_home')
                      {
                        navigateTo(context,
                            HomePage(email: email, nome: nome, coord: false))
                      }
                  }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.monetization_on),
              title: const Text('Emprestimos de aluno'),
              onTap: () =>
                  navigateTo(context, CheckinEquip(email: email, nome: nome))),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Suas solicitações'),
            onTap: () => navigateTo(context, Solicitacoes()),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Meus horarios'),
            onTap: () =>
                navigateTo(context, Horarios(email: email, nome: nome)),
          ),
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

class NavBarCoordenador extends NavBase {
  NavBarCoordenador(
      {required String nome,
      required String email,
      required BuildContext cont,
      required String pageName})
      : super(nome: nome, email: email, cont: cont, pageName: pageName);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: navBarSize(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //cabeçalho
          const UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text(''),
            currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/assets/guest.png')),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    image: AssetImage('lib/assets/ueaLogo.jpg'),
                    fit: BoxFit.cover)),
          ),
          //itens da navbar
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () => {
              if (pageName != 'coordenador_home')
                {
                  navigateTo(
                      context, HomePage(email: email, nome: nome, coord: true))
                }
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
                      {
                        navigateTo(
                            context, ViewEquipment(nome: nome, email: email))
                      }
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
                            context, ViewSolicitacoes(nome: nome, email: email))
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
