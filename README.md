# Projeto Moblie
>[!Important]
>- Turma: 3°Mtec Desenvolvimento de Jogos Digitais.
>- Escola: Etec Prof. Basilides de Godoy.
>- Sobre: Repositório para a documentação de um projeto mobile, um trabalho proposto pela professora Aline Firmino Brito da Etec Prof. Basilides de Godoy.
>- Datas: Entrega de Atividade (20/05/2025).

>[!Important]
 > ` - Dupla:`
>- Felipe Mussato Rodrigues
>- Guilherme Henrique Lemes Souza

# Imagens prototipo

### Tela inicial

![Group 10 (1)](https://github.com/user-attachments/assets/183e280e-f367-421f-a20f-292955e04ad4)

### Tela de informação do Filme

![Group 11](https://github.com/user-attachments/assets/b2246d89-b52c-4d11-b21a-7266fb9e2fc1)

 ### Mapa de navegação

![MapaNavegacao](https://github.com/user-attachments/assets/2fb2d631-ac06-4316-b7bf-145f247ea254)


  #### Tela inicial ->  Tela de informação do Filme
  #### Tela de informação do filme -> Tela inicial
  
# Descrição detalhada da aplicação 
Apresenta os filmes inspirações por meio de uma lista criada a mão, a tela inicial é composta por diversos Cards cada um com os filmes expecificados.
Quando clicado é mandando para outra tela com toda a informação do filme selecionado apresentando:<br>
sinopse; <br>
direção/produção; <br>
empresa/studio; <br>
gênero; <br>
dados de lançamento; <br>
elenco;<br>
galeria de imagens; <br>
link para o trailer;<br>
link para site oficial/redes sociais.

# Widgets utilizados 
### Tela Inicial
- AppBar: Barra superior do aplicativo
- Icon: utilizado na AppBar mostra o icone de Lupa 
- TextField: Utilizada na AppBar, para ser um campo de pesquisa  
- Text: Cria um campo onde mostra textos
- GridView: Utilizado para organizar os campos onde aparecerão os filmes
- Card: Utilizado para criar os cards onde mostra os filmes 
- Column: Cria uma coluna onde alinha as informações do filme
- Image: Mostra a imagem do filme expecifico
- Expanded: Ele se ajusta de acordo com o tamnho disponivel 
- Padding: Ajusta o espaçamento da tela 

### Tela do filme 
- Center: Deixa os elemntos da tela centralizados
- SizedBox: Utilizado para criar um espaço em branco
- Row: cria uma linha para melhor ajuste 
- ElevatedButton: Cria um Botão

# Codigos aplicativo
### Tela Inicial
```dart

import "package:flutter/material.dart";
import "package:index_cine/Filme.dart";
import "detalhesfilme.dart";
import "filmes.dart";

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
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 0.75, 
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


```
### Tela dos filmes
```dart

import "package:flutter/material.dart";
import "Filme.dart";
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
                image: AssetImage(filme.imagemPrincipal),
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
                filme.nome,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(filme.dataLancamento,
                      style: texto(), textAlign: TextAlign.justify),
                  SizedBox(
                    width: 125,
                  ),
                  Text(filme.genero,
                      style: texto(), textAlign: TextAlign.justify),
                  SizedBox(
                    width: 120,
                  ),
                  Text(
                    "⭐ ${filme.avaliacao}",
                    style: texto(),
                  ),
                ],
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
                        image: AssetImage(url),
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
                    final url = Uri.parse(filme.trailer);
                    launchUrl(url, mode: LaunchMode.externalApplication);
                  },
                  child: Text(
                    "Trailer do filme",
                  ),
                ),
              ),
              Text("Sinopse", style: titulo(), textAlign: TextAlign.justify),
              Text(filme.sinopse, style: texto(), textAlign: TextAlign.justify),
              SizedBox(height: 12),
              Text("Direção/Produção",
                  style: titulo(), textAlign: TextAlign.justify),
              Text(filme.direcao, style: texto(), textAlign: TextAlign.justify),
              SizedBox(height: 12),
              Text("Empresa/Estúdio",
                  style: titulo(), textAlign: TextAlign.justify),
              Text(filme.empresa, style: texto(), textAlign: TextAlign.justify),
              SizedBox(height: 12),
              Text("Elenco", style: titulo(), textAlign: TextAlign.justify),
              Text(filme.elenco, style: texto(), textAlign: TextAlign.justify),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

 //Metodos de estilização
  TextStyle titulo() =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle texto() => TextStyle(color: Colors.white, fontSize: 14);
}
 
```

### Classe dos filmes
```dart

class Filme{
  final String nome;
  final String sinopse;
  final String direcao;
  final String empresa;
  final String genero;
  final String dataLancamento;
  final String elenco;
  final String trailer;
  final List<String> galeria;
  final double avaliacao;
  final String imagemPrincipal;

  Filme({
    required this.nome,
    required this.sinopse,
    required this.direcao,
    required this.empresa,
    required this.genero,
    required this.dataLancamento,
    required this.elenco,
    required this.trailer,
    required this.galeria,
    required this.avaliacao,
    required this.imagemPrincipal,
  });
}

``` 
### Declaração dos filmes
```dart
import "Filme.dart";


final List<Filme> filmes = [
  Filme(
    nome: "Cidade de Deus",
    sinopse:
        "Dadinho (Douglas Silva) e Buscapé são grandes amigos, que cresceram juntos imersos em um universo de muita violência. Na Cidade de Deus, favela carioca conhecida por ser um dos locais mais violentos do Rio de Janeiro, os caminhos das duas crianças divergem, quando um se esforça para se tornar um fotógrafo e o outro o chefe do tráfico. Buscapé (Alexandre Rodrigues) é um jovem pobre, negro e muito sensível, que vive amedrontado com a possibilidade de se tornar um bandido, e acaba sendo salvo de seu destino por causa de seu talento como fotógrafo, o qual permite que siga carreira na profissão. É através de seu olhar atrás da câmera que Buscapé analisa o dia-a-dia da favela onde vive, enquanto Dadinho, agora Zé Pequeno (Leandro Firmino), se torna o temido chefe do tráfico da região, continuando com o legado de violência que remonta a décadas anteriores - e parece ser infinita. Considerado um dos melhores filmes da história do cinema brasileiro.",
    direcao: "Fernando Meirelles, Kátia Lund",
    empresa: "O2 Filmes, Globo Filmes",
    genero: "Drama, Crime",
    dataLancamento: "2002",
    elenco: "Alexandre Rodrigues, Leandro Firmino, Seu Jorge",
    trailer:"https://www.youtube.com/watch?v=fZJUKixyeXM",
    galeria: [
      "Img/cidade/Deuscapa.png",
      "Img/cidade/imagem1.jpg",
      "Img/cidade/imagem2.webp",
      "Img/cidade/imagem3.jpg",
      "Img/cidade/imagem4.jpg",
    ],
    avaliacao: 4.9,
    imagemPrincipal: "Img/cidade/Deuscapa.png",
  ),
  Filme(
    nome: "Mãos Talentosas",
    sinopse:
        "Ben Carson (Cuba Gooding Jr.), menino pobre de Detroit, sempre levou uma vida desmotivada, já que tirava notas baixas e não tinha perspectivas de um grande futuro.\n O que ele e os que estavam ao redor não esperavam era que ele se tornaria um neurocirurgião de fama mundial.",
    direcao: "Thomas Carter",
    empresa: "Sony Pictures Television",
    genero: "Biografia, Drama",
    dataLancamento: "2009",
    elenco: "Cuba Gooding Jr., Kimberly Elise",
    trailer:"https://www.youtube.com/watch?v=ayAaXVx_YVo",
    galeria: [
      "Img/talentosas/capa.jpg",
      "Img/talentosas/imagem1.webp",
      "Img/talentosas/imagem2.jpg",
      "Img/talentosas/imagem3.jpg",
      "Img/talentosas/imagem4.jpg",
    ],
    avaliacao: 4.7,
    imagemPrincipal: "Img/talentosas/capa.jpg",
  ),
  Filme(
    nome: "O Senhor dos Anéis: A Sociedade do Anel",
    sinopse:
        "Numa terra fantástica e única, chamada Terra-Média, um hobbit (seres de estatura entre 80 cm e 1,20 m, com pés peludos e bochechas um pouco avermelhadas) recebe de presente de seu tio o Um Anel, um anel mágico e maligno que precisa ser destruído antes que caia nas mãos do mal. Para isso o hobbit Frodo (Elijah Woods) terá um caminho árduo pela frente, onde encontrará perigo, medo e personagens bizarros. Ao seu lado para o cumprimento desta jornada aos poucos ele poderá contar com outros hobbits, um elfo, um anão, dois humanos e um mago, totalizando 9 pessoas que formarão a Sociedade do Anel.",
    direcao: "Peter Jackson",
    empresa: "New Line Cinema",
    genero: "Fantasia, Aventura",
    dataLancamento: "2001",
    elenco: "Elijah Wood, Ian McKellen, Viggo Mortensen",
    trailer:"https://www.youtube.com/watch?v=0i86oM1nHjM",
    galeria: [
      "Img/sociAnel/capa.jpg",
      "Img/sociAnel/imagem1.jpg",
      "Img/sociAnel/imagem2.webp",
      "Img/sociAnel/imagem3.jpg",
      "Img/sociAnel/imagem1.jpg",
    ],
    avaliacao: 5.0,
    imagemPrincipal: "Img/sociAnel/capa.jpg",
  ),
  Filme(
    nome: "O Senhor dos Anéis: As Duas Torres",
    sinopse:
        "Após a captura de Merry (Dominic Monaghan) e Pippy (Billy Boyd) pelos orcs, a Sociedade do Anel é dissolvida. Enquanto que Frodo (Elijah Wood) e Sam (Sean Astin) seguem sua jornada rumo à Montanha da Perdição para destruir o Um Anel, Aragorn (Viggo Mortensen), Legolas (Orlando Bloom) e Gimli (John Rhys-Davies) partem para resgatar os hobbits sequestrados.",
    direcao: "Peter Jackson",
    empresa: "New Line Cinema",
    genero: "Fantasia, Aventura",
    dataLancamento: "2002",
    elenco: "Elijah Wood, Ian McKellen, Orlando Bloom",
    trailer:"https://www.youtube.com/watch?v=Al5iC4CnhYc",
    galeria: [
      "Img/duastorre/capa.jpg",
      "Img/duastorre/imagem1.jpg",
      "Img/duastorre/imagem2.jpg",
      "Img/duastorre/imagem3.jpg",
      "Img/duastorre/imagem4.jpg",
      "Img/duastorre/imagem5.jpg",
    ],
    avaliacao: 4.9,
    imagemPrincipal: "Img/duastorre/capa.jpg",
  ),
  Filme(
    nome: "O Senhor dos Anéis: O Retorno do Rei",
    sinopse:
        "Sauron planeja um grande ataque a Minas Tirith, capital de Gondor, o que faz com que Gandalf (Ian McKellen) e Pippin (Billy Boyd) partam para o local na intenção de ajudar a resistência. Um exército é reunido por Theoden (Bernard Hill) em Rohan, em mais uma tentativa de deter as forças de Sauron. Enquanto isso Frodo (Elijah Wood), Sam (Sean Astin) e Gollum (Andy Serkins) seguem sua viagem rumo à Montanha da Perdição, para destruir o Um Anel.",
    direcao: "Peter Jackson",
    empresa: "New Line Cinema",
    genero: "Fantasia, Aventura",
    dataLancamento: "2003",
    elenco: "Elijah Wood, Viggo Mortensen, Ian McKellen",
    trailer:"https://www.youtube.com/watch?v=LiKeQrChkTY",
    galeria: [
      "Img/returnrei/capa1.jpg",
      "Img/returnrei/imagem1.jpg",
      "Img/returnrei/imagem2.webp",
      "Img/returnrei/imagem3.webp",
      "Img/returnrei/imagem4.webp",
      "Img/returnrei/imagem5.jpg",
    ],
    avaliacao: 5.0,
    imagemPrincipal: "Img/returnrei/capa1.jpg",
  ),
  Filme(
    nome: "Indiana Jones e os Caçadores da Arca Perdida",
    sinopse:
        "Em 1936, o arqueólogo e aventureiro Indiana Jones é contratado pelo governo americano para encontrar a Arca da Aliança, um artefato bíblico que conteria os Dez Mandamentos. A missão se torna mais perigosa ao saber que os nazistas também estão atrás da relíquia sagrada, que daria a quem a possuir um poder inimaginável. Com a ajuda de Marion e Sallah, Indy viaja por diferentes países em busca da Arca, enfrentando armadilhas mortais, rivais perigosos e dilemas morais.",
    direcao: "Steven Spielberg",
    empresa: "Paramount Pictures",
    genero: "Aventura, Ação",
    dataLancamento: "1981",
    elenco: "Harrison Ford, Karen Allen, Paul Freeman",
    trailer: "https://www.youtube.com/watch?v=XkkzKHCx154",
    galeria: [
      "Img/IJarca/capa.jpg",
      "Img/IJarca/imagem1.jpeg",
      "Img/IJarca/imagem2.jpeg",
      "Img/IJarca/imagem3.jpg",
      "Img/IJarca/imagem4.webp",
    ],
    avaliacao: 4.8,
    imagemPrincipal: "Img/IJarca/capa.jpg",
  ),
  Filme(
    nome: "Indiana Jones: O Templo da Perdição",
    sinopse:
        "Em 1935, o professor, arqueólogo e aventureiro Indiana Jones (Harrison Ford) tem uma nova missão: resgatar as pedras roubadas por um feiticeiro e libertar crianças escravizadas. Para tanto, enfrenta os poderes mágicos e o fanatismo de um culto que sacrifica seres humanos.",
    direcao: "Steven Spielberg",
    empresa: "Paramount Pictures",
    genero: "Ação, Aventura",
    dataLancamento: "1984",
    elenco: "Harrison Ford, Kate Capshaw",
    trailer: "https://www.youtube.com/watch?v=WBdyLyijZhU",
    galeria: [
      "Img/IJtemplo/capa.webp",
      "Img/IJtemplo/imagem1.jpeg",
      "Img/IJtemplo/imagem2.jpeg",
      "Img/IJtemplo/imagem3.jpg",
      "Img/IJtemplo/imagem4.jpg",
    ],
    avaliacao: 4.4,
    imagemPrincipal: "Img/IJtemplo/capa.webp",
  ),
  Filme(
    nome: "Indiana Jones: A Última Cruzada",
    sinopse:
        "O arqueólogo Indiana Jones (Harrisson Ford) tem acesso à um misterioso envelope que contém informações sobre a localização do lendário Santo Graal, o cálice que Jesus Cristo teria utilizado na Última Ceia. Quando seu pai, o professor Henry Jones (Sean Connery), é sequestrado pelos nazistas, o aventureiro irá embarcar numa missão perigosa para salvá-lo e impedir que a relíquia sagrada caia em mãos erradas.",
    direcao: "Steven Spielberg",
    empresa: "Paramount Pictures",
    genero: "Ação, Aventura",
    dataLancamento: "1989",
    elenco: "Harrison Ford, Sean Connery",
    trailer: "https://www.youtube.com/watch?v=sagmdpkWUqc",
    galeria: [
      "Img/IJcruzada/capa.webp",
      "Img/IJcruzada/imagem1.jpeg",
      "Img/IJcruzada/imagem2.jpg",
      "Img/IJcruzada/imagem3.jpg",
      "Img/IJcruzada/imagem4.jpg",
    ],
    avaliacao: 4.7,
    imagemPrincipal: "Img/IJcruzada/capa.webp",
  ),
  Filme(
    nome: "Indiana Jones: O Reino da Caveira de Cristal",
    sinopse:
        "Indiana Jones (Harrison Ford) e seu ajudante Mac (Ray Winstone) escapam por pouco de um encontro com agentes soviéticos, em um campo de pouso remoto. Agora Indiana está de volta à sua casa na Universidade Marshall, mas seu amigo e reitor da escola, Dean Stanforth (Jim Broadbent), explica que suas ações recentes o tornaram alvo de suspeita e que o governo está pressionando para que o demita. Ao deixar a cidade Indiana conhece o rebelde jovem Mutt Williams (Shia LaBeouf), que tem uma proposta: caso o ajude em uma missão Indiana pode deparar-se com a caveira de cristal de Akator. Agentes soviéticos também estão em busca do artefato, entre eles a fria e bela Irina Spalko (Cate Blanchett), cujo esquadrão de elite está cruzando o globo atrás da Caveira de Cristal.",
    direcao: "Steven Spielberg",
    empresa: "Paramount Pictures",
    genero: "Ação, Aventura, Ficção Científica",
    dataLancamento: "2008",
    elenco: "Harrison Ford, Shia LaBeouf, Cate Blanchett",
    trailer: "https://www.youtube.com/watch?v=WAdJf4wTC5Y",
    galeria: [
      "Img/IJcaveira/capa.jpg",
      "Img/IJcaveira/imagem1.jpg",
      "Img/IJcaveira/imagem2.webp",
      "Img/IJcaveira/imagem3.jpeg",
    ],
    avaliacao: 4.0,
    imagemPrincipal: "Img/IJcaveira/capa.jpg",
  ),
  Filme(
    nome: "Indiana Jones: A Relíquia do Destino",
    sinopse:
        "Em Indiana Jones e a Relíquia do Destino, Indiana Jones (Harrisson Ford), famoso arqueólogo, professor e aventureiro, embarca em mais uma missão inesperada. Neste retorno do herói lendário, Indiana Jones, na quinta parcela da icônica série de filmes, encontra-se em uma nova era, aproximando-se da aposentadoria. Ele luta para se encaixar em um mundo que parece tê-lo superado. Mas quando as garras de um mal muito familiar retornam na forma de um antigo rival, Indiana Jones deve colocar seu chapéu e pegar seu chicote mais uma vez para garantir que um antigo e poderoso artefato não caia nas mãos erradas. Mas, desta vez, ele tem o sangue de uma nova geração para o ajudar nas suas descobertas e na sua luta contra o vilão Jürgen Voller (Mads Mikkelsen). Acompanhado de sua afilhada, Helena Shaw (Phoebe Waller-Bridge), o arqueólogo corre contra o tempo para recuperar o item que pode mudar o curso da história.",
    direcao: "James Mangold",
    empresa: "Walt Disney Studios",
    genero: "Ação, Aventura",
    dataLancamento: "2023",
    elenco: "Harrison Ford, Phoebe Waller-Bridge",
    trailer: "https://www.youtube.com/watch?v=eQfMbSe7F2g",
    galeria: [
      "Img/IJdestino/capa.webp",
      "Img/IJdestino/imagem1.jpeg",
      "Img/IJdestino/imagem2.jpeg",
      "Img/IJdestino/imagem3.webp",
      "Img/IJdestino/imagem4.jpeg",
    ],
    avaliacao: 4.2,
    imagemPrincipal: "Img/IJdestino/capa.webp",
  ),
];

```
