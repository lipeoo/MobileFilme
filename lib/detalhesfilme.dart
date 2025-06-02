// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'Filme.dart';
import "package:url_launcher/url_launcher.dart";

class DetalhesFilme extends StatelessWidget {
  final Filme filme;

  Icon icone = Icon(Icons.star_outlined);

  DetalhesFilme({required this.filme});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          filme.nome,
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: Color.fromRGBO(174, 0, 255, 150),
        toolbarHeight: 90,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                filme.imagemPrincipal,
                height: 1200,
                width: 1200,
              ),
              SizedBox(height: 16),
              Text('Sinopse', style: titulo()),
              Text(filme.sinopse, style: texto()),
              SizedBox(height: 12),
              Text('Direção/Produção', style: titulo()),
              Text(
                filme.direcao,
                style: texto(),
              ),
              SizedBox(height: 12),
              Text('Empresa/Estúdio', style: titulo()),
              Text(filme.empresa, style: texto()),
              SizedBox(height: 12),
              Text('Gênero', style: titulo()),
              Text(filme.genero, style: texto()),
              SizedBox(height: 12),
              Text('Data de Lançamento', style: titulo()),
              Text(filme.dataLancamento, style: texto()),
              SizedBox(height: 12),
              Text('Elenco', style: titulo()),
              Text(
                filme.elenco,
                style: texto(),
              ),
              SizedBox(height: 12),
              Text('Avaliação', style: titulo()),
              Text(
                '${filme.avaliacao}',
                style: texto(),
              ),
              SizedBox(height: 12),
              Text('Galeria de Imagens', style: titulo()),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: filme.galeria.map((url) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.network(url, width: 150),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    final Url = Uri.parse(filme.trailer);
                    launchUrl(Url, mode: LaunchMode.externalApplication);
                  },
                  child: Text(
                    "Trailer do filme",
                  ))
            ],
          ),
        ),
      ),
    );
  }

  TextStyle titulo() =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle texto() => TextStyle(color: Colors.white, fontSize: 14);
}
