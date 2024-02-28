import 'package:flutter/material.dart';
import 'package:iot_scrty/pages/_environment.dart';
import 'package:iot_scrty/pages/_equipments.dart';
import 'package:iot_scrty/pages/_home_page.dart';
import 'package:iot_scrty/pages/_register_loan.dart';
import 'package:iot_scrty/pages/_solicitations.dart';
import 'package:iot_scrty/pages/_colaborators.dart';

abstract class NavBase extends StatelessWidget {
  final BuildContext cont;
  final String pageName;

  void navigateTo(context, Widget page) {
    if (pageName == 'home') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => page));
    }
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
                    if (pageName != 'home')
                      {navigateTo(context, HomePage(coord: false))}
                    else
                      {Navigator.of(context).pop()}
                  }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('Emprestimo Barcode/QRCode'),
              onTap: () => {
                    if (pageName != 'checkin')
                      {navigateTo(context, const CheckinEquip())}
                    else
                      {Navigator.of(context).pop()}
                  }),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.auto_stories),
              title: const Text('Emprestimo Manual'),
              onTap: () => {
                    if (pageName != 'Emprestimo manual')
                      {navigateTo(context, const CheckinManual())}
                    else
                      {Navigator.of(context).pop()}
                  }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Suas solicitações'),
            onTap: () => {
              if (pageName != 'solicitacoes')
                {navigateTo(context, const Solicitacoes())}
              else
                {Navigator.of(context).pop()}
            },
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
              if (pageName != 'home')
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
                      {navigateTo(context, const SolicitacoesCoord())}
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
