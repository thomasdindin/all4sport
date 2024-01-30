class Article {
  late String _productName;
  late String _productDescription;
  late int _productPrice;
  late String _productReference;
  late int _rayonId;

  Article(this._productName, this._productDescription, this._productPrice, this._productReference);

  // Le constructeur fromJSON doit s'assurer d'initialiser tous les champs.
  Article.fromJSON(Map<String, dynamic> json) {
    _productName = json['nom'] as String; // Remplacez 'nom' par la clé appropriée du JSON
    _productDescription = json['description'] as String; // Remplacez 'description' par la clé appropriée du JSON
    _productPrice = json['prix'] as int; // Remplacez 'prix' par la clé appropriée du JSON
    _productReference = json['reference'] as String; // Remplacez 'reference' par la clé appropriée du JSON
    _rayonId = int.parse((json['rayonId'] as String).split('/')[3]); // On récupère le rayonId à partir de l'URL
  }

  // Les getters restent inchangés
  String get productName => _productName;
  String get productDescription => _productDescription;
  int get productPrice => _productPrice;
  String get productReference => _productReference;
  int get rayonId => _rayonId;

  // La méthode toJSON reste inchangée
  Map<String, dynamic> toJSON() {
    return {
      'productName': _productName,
      'productDescription': _productDescription,
      'productPrice': _productPrice,
      'productReference': _productReference,
    };
  }

}
