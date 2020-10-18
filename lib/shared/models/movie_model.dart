class MovieModel {
  MovieModel({
    this.data,
    this.genero,
    this.link,
    this.poster,
    this.sinopse,
    this.sinopseFull,
    this.titulo,
  });

  final String data;
  final String genero;
  final String link;
  final String poster;
  final String sinopse;
  final String sinopseFull;
  final String titulo;

  factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
        data: json["data"] as String,
        genero: json["genero"] as String,
        link: json["link"] as String,
        poster: json["poster"] as String,
        sinopse: json["sinopse"] as String,
        sinopseFull: json["sinopseFull"] as String,
        titulo: json["titulo"] as String,
      );

  Map<String, dynamic> toMap() => {
        "data": data,
        "genero": genero,
        "link": link,
        "poster": poster,
        "sinopse": sinopse,
        "sinopseFull": sinopseFull,
        "titulo": titulo,
      };

  @override
  bool operator ==(other) =>
      other is MovieModel &&
      other.data == this.data &&
      other.genero == this.genero &&
      other.link == this.link &&
      other.poster == this.poster &&
      other.sinopse == this.sinopse &&
      other.sinopseFull == this.sinopseFull &&
      other.titulo == this.titulo;

  @override
  int get hashCode =>
      this.data.hashCode ^
      this.genero.hashCode ^
      this.link.hashCode ^
      this.poster.hashCode ^
      this.sinopse.hashCode ^
      this.sinopseFull.hashCode ^
      this.titulo.hashCode;
}
