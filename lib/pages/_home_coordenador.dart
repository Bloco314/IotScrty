import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iot_scrty/components/buttons.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/top_bar.dart';

class HomeCState extends StatelessWidget {
  final String email;
  final String nome;
  final List<String> images = [
    'lib/assets/ueaLogo.jpg',
    'lib/assets/informatic_lab.png',
    'lib/assets/mori.jpeg'
  ];

  HomeCState({required this.email, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarCoordenador(
            email: email,
            nome: nome,
            cont: context,
            pageName: 'coordenador_home'),
        appBar: TopBar(text: 'Bem-vindo${nome.isNotEmpty ? ', ' : ''}$nome'),
        //corpo
        body: Padding(
          padding: EdgeInsets.all(16.0),
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
            Divider(),
            Text('Universidade do estado do Amazonas'),
            Text('Escola superior de tecnologia'),
            Divider(),
            //Outro
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButton(
                    width: 160, text: 'Trocar senha', onPressed: () => null),
                PrimaryButton(
                    width: 160, text: 'Creditos', onPressed: () => null)
              ],
            ),
            Divider(),
          ]),
        ));
  }
}
