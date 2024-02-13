import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/top_bar.dart';
import 'package:iot_scrty/pages/_credits.dart';

class HomePage extends StatelessWidget {
  final bool coord;
  final List<String> images = [
    'lib/assets/ueaLogo.jpg',
    'lib/assets/informatic_lab.png',
    'lib/assets/mori.jpeg'
  ];

  HomePage({super.key, required this.coord});

  void navigateTo(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: coord
            ? NavBarCoordenador(cont: context, pageName: 'coordenador_home')
            : NavBarProfessor(cont: context, pageName: 'professor_home'),
        appBar: const TopBar(text: 'Bem-vindo'),
        //corpo
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            //Carrosel com noticias
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: images.map((String image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const Divider(),
            const Text('Universidade do estado do Amazonas'),
            const Text('Escola superior de tecnologia'),
            const Divider(),
            //Outro
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButton(
                    width: 160, text: 'Trocar senha', onPressed: () => {}),
                const SizedBox(width: 10),
                PrimaryButton(
                    width: 160,
                    text: 'Creditos',
                    onPressed: () => navigateTo(context, const Credits()))
              ],
            ),
            const Divider(),
          ]),
        ));
  }
}
