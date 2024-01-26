class Rayon {
  int _id;
  String _nom;
  Article[] _articles;

  Rayon({required this._id,required this._nom});

  Rayon.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nom'] = this._nom;
    return data;
  }

}