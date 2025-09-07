// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unnecessary_string_interpolations

import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:index_cine/Filme.dart";
import "detalhesfilme.dart";

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaFilmes(filmes: listaFilmes),
      debugShowCheckedModeBanner: false,
    );
  }

  List<Filme> listaFilmes = List.empty();

  Future<void> readJson() async {
    final String response = await rootBundle.loadString("Assets/filmes.json");
    Iterable data = await json.decode(response);
    listaFilmes = List<Filme>.from(data.map((model) => Filme.fromJson(model)));
    setState(() {
      listaFilmes;
    });
  }
}

class ListaFilmes extends StatefulWidget {
  final List<Filme> filmes;

  ListaFilmes({required this.filmes});

  @override
  State<ListaFilmes> createState() => _ListaFilmesState();
}

class _ListaFilmesState extends State<ListaFilmes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Image(
              image: AssetImage("Assets/Img/Logo.png"),
            )),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
        title: const Text(
          "IndexCine",
          style: TextStyle(color: Colors.white, fontFamily: "Buran USSR"),
        ),
        backgroundColor: Color.fromRGBO(85, 0, 125, 1),
        toolbarHeight: 90,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          itemCount: widget.filmes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dois por linha
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 0.75, // Largura/Altura, ajuste como quiser
          ),
          itemBuilder: (context, index) {
            final filme = widget.filmes[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalhesFilme(filme: filme)),
                );
              },
              child: Card(
                color: Color.fromRGBO(216, 216, 216, 1),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Image(
                        image: AssetImage("${filme.imagemPrincipal}"),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image, size: 40);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filme.nome,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "⭐ ${filme.avaliacao}",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                            Text(
                              "Lançamento: ${filme.dataLancamento}",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 3, 3, 3)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
