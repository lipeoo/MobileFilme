class Filme {
  late String nome;
  late String sinopse;
  late String direcao;
  late String empresa;
  late String genero;
  late String dataLancamento;
  late String elenco;
  late String trailer;
  late List<String> galeria;
  late double avaliacao;
  late String imagemPrincipal;

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

  Filme.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    sinopse = json['sinopse'];
    direcao = json['direcao'];          
    empresa = json['empresa'];
    genero = json['genero'];
    dataLancamento = json['dataLancamento'];
    elenco = json['elenco'];
    trailer = json['trailer'];
    galeria = json['galeria'].cast<String>();
    avaliacao = json['avaliacao'];
    imagemPrincipal = json['imagemPrincipal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['sinopse'] = this.sinopse;
    data['direcao'] = this.direcao;
    data['empresa'] = this.empresa;
    data['genero'] = this.genero;
    data['dataLancamento'] = this.dataLancamento;
    data['elenco'] = this.elenco;
    data['trailer'] = this.trailer;
    data['galeria'] = this.galeria;
    data['avaliacao'] = this.avaliacao;
    data['imagemPrincipal'] = this.imagemPrincipal;
    return data;
  }
}
