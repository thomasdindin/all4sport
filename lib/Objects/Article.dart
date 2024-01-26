class Article {
  String _productName;
  String _productDescription;
  int _productPrice;
  String _productImage;

  Article(this._productName, this._productDescription, this._productImage, this._productPrice);

  Article.fromJSON(Map<String, dynamic> json) {
    this._productName = json['productName'];
    this._productDescription = json['productDescription'];
    this._productImage = json['productImage'];
    this._productPrice = json['productPrice'];
  }
}