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
        backgroundColor: Color.fromRGBO(85, 0, 125, 1),
        toolbarHeight: 90,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                alignment: Alignment.center,
                image: AssetImage("${filme.imagemPrincipal}"),
                height: 500,
                width: 500,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.broken_image,
                    size: 40,
                    color: Color.fromARGB(169, 241, 239, 239),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                "${filme.nome}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(height: 5),
              Container(
                child: Row(
                  children: [
                    Text(filme.dataLancamento,
                        style: texto(), textAlign: TextAlign.justify),
                    SizedBox(
                      width: 125,
                    ),
                    Text(filme.genero,
                        style: texto(), textAlign: TextAlign.justify),
                    SizedBox(
                      width: 125,
                    ),
                    Text(
                      '⭐ ${filme.avaliacao}',
                      style: texto(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: filme.galeria.map((url) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image(
                        image: AssetImage("$url"),
                        width: 150,
                        height: 120,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Color.fromARGB(169, 241, 239, 239),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor: WidgetStateProperty.all(
                        Color.fromRGBO(85, 0, 125, 1),
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      minimumSize: WidgetStateProperty.all(Size(50, 50))),
                  onPressed: () {
                    final Url = Uri.parse(filme.trailer);
                    launchUrl(Url, mode: LaunchMode.externalApplication);
                  },
                  child: Text(
                    "Trailer do filme",
                  ),
                ),
              ),
              Text('Sinopse', style: titulo(), textAlign: TextAlign.justify),
              Text(filme.sinopse, style: texto(), textAlign: TextAlign.justify),
              SizedBox(height: 12),
              Text('Direção/Produção',
                  style: titulo(), textAlign: TextAlign.justify),
              Text(filme.direcao, style: texto(), textAlign: TextAlign.justify),
              SizedBox(height: 12),
              Text('Empresa/Estúdio',
                  style: titulo(), textAlign: TextAlign.justify),
              Text(filme.empresa, style: texto(), textAlign: TextAlign.justify),
              SizedBox(height: 12),
              Text('Elenco', style: titulo(), textAlign: TextAlign.justify),
              Text(filme.elenco, style: texto(), textAlign: TextAlign.justify),
              SizedBox(height: 12),
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
