import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iot_scrty/components/navigation_bar.dart';
import 'package:iot_scrty/components/top_bar.dart';

class HomeCState extends StatelessWidget {
  final String email;
  final String nome;
  final List<String> images = [
    'http://data.uea.edu.br/ssgp/noticia/1/77157.png',
    'https://imgs.search.brave.com/oiikbAYjZui3eMw31BFZEDnrwwIkXAd5ylwjbFjv-cM/rs:fit:500:0:0/g:ce/aHR0cHM6Ly92ZXN0/aWJ1bGFyZXMyMDIy/LmNvbS5ici93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyMS8wMi9h/bTEuanBn',
    'https://imgs.search.brave.com/1rvZH2M_58rKizK8BcVNIzlyeyCSqNKLex6uq5t4STA/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9mYXN0/bHkuNHNxaS5uZXQv/aW1nL2dlbmVyYWwv/NjAweDYwMC9sRmVR/TGtvTWhTT01nMHhx/c2J0a2RMWjdraHpP/VFdnQWZmV2FXM3pW/bEYwLmpwZw',
    'https://imgs.search.brave.com/d8T8d6hf8FWoeRWIg6BGzFkPuKILhauNFwtqaTNCmx0/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9mYXN0/bHkuNHNxaS5uZXQv/aW1nL2dlbmVyYWwv/NjAweDYwMC8zMTY0/NjQyM19yVkwyX3F0/ckxFMWVnYnhSQXN3/R00zQmRZZ1ZScFU5/T2gtSm9fRk1yYi1r/LmpwZw'
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
      appBar: TopBar(
          text:
              'Bem-vindo${nome.isNotEmpty ? ', ' : ''}$nome'),
      //corpo
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: CarouselSlider(
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
            items: images.map((String imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          )),
    );
  }
}
