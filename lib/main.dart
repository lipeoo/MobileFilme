import 'package:flutter/material.dart';
import 'package:index_cine/Filme.dart';
import 'detalhesfilme.dart';
import 'filmes.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaFilmes(filmes: filmes),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ListaFilmes extends StatelessWidget {
  final List<Filme> filmes;

  ListaFilmes({required this.filmes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Image(
          image: AssetImage("Img/Logo.png"), 
          )
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
        title: const Text("IndexCine",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Buran USSR" 
            ),
            ),
        backgroundColor: Color.fromRGBO(85, 0, 125, 1),
        toolbarHeight: 90,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          itemCount: filmes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dois por linha
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 0.75, // Largura/Altura, ajuste como quiser
          ),
          itemBuilder: (context, index) {
            final filme = filmes[index];
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
                              '⭐ ${filme.avaliacao}',
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                            Text(
                              'Lançamento: ${filme.dataLancamento}',
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
