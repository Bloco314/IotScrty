import 'package:flutter/material.dart';
import 'package:iot_scrty/pages/_environment.dart';
import 'package:iot_scrty/pages/_equipments.dart';
import 'package:iot_scrty/pages/_home_page.dart';
import 'package:iot_scrty/pages/_horarios_professor.dart';
import 'package:iot_scrty/pages/_register_loan.dart';
import 'package:iot_scrty/pages/_solicitations.dart';
import 'package:iot_scrty/pages/_colaborators.dart';

abstract class NavBase extends StatelessWidget {
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

  const NavBase({super.key, required this.cont, required this.pageName});
}

class NavBarProfessor extends NavBase {
  const NavBarProfessor(
      {super.key, required super.cont, required super.pageName});

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
                      {navigateTo(context, HomePage(coord: false))}
                  }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.monetization_on),
              title: const Text('Emprestimos de aluno'),
              onTap: () => navigateTo(context, CheckinEquip())),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Suas solicitações'),
            onTap: () => navigateTo(context, const Solicitacoes()),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Meus horarios'),
            onTap: () => navigateTo(context, Horarios()),
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
  const NavBarCoordenador(
      {super.key, required super.cont, required super.pageName});

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
                {navigateTo(context, HomePage(coord: true))}
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
                      {navigateTo(context, const ViewEnvironments())}
                    else
                      {Navigator.of(context).pop()}
                  }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.computer),
              title: const Text('Equipamentos'),
              onTap: () => {
                    if (pageName != 'cadastrar_equipamentos')
                      {navigateTo(context, const ViewEquipment())}
                    else
                      {Navigator.of(context).pop()}
                  }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.wechat),
              title: const Text('Solicitações'),
              onTap: () => {
                    if (pageName != 'solicitacoes')
                      {navigateTo(context, ViewSolicitacoes())}
                    else
                      {Navigator.of(context).pop()}
                  }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Colaboradores'),
              onTap: () => {
                    if (pageName != 'colaboradores')
                      {navigateTo(context, const Colaboradores())}
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
