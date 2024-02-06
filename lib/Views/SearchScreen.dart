import 'package:all4sport/Objects/Article.dart';
import 'package:all4sport/Services/StateManager.dart';
import 'package:all4sport/Views/Components/BottomBar.dart';
import 'package:all4sport/Views/Components/PanierFab.dart';
import 'package:all4sport/Views/QRScanScreen.dart';
import 'package:flutter/material.dart';
import 'Components/ArticleView.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  String _selectedFilter = 'Tous';

  final AppState appState = AppState.getInstance();

  List<Article> _filteredProducts() {
    final _products = appState.rayons
        .map((rayon) => rayon.produits)
        .expand((element) => element)
        .toList();
    if (_searchText == '') {
      return _products;
    } else {
      return _products.where((product) {
        if (product.productName.toLowerCase().contains(_searchText.toLowerCase())) {
          return true;
        } else if (product.productReference.toLowerCase().contains(_searchText.toLowerCase())) {
          return true;
        } else if (product.productDescription.toLowerCase().contains(_searchText.toLowerCase())) {
          return true;
        } else {
          return false;
        }
      }).toList();
    }
  }

  void _openQRScanner() {
    // Ouvrir une nouvelle page ou un dialogue pour le scanner
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const QRScanPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Champ de recherche
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                    _filteredProducts();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Rechercher un produit...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // Ajoutez ici la logique de recherche
                      // Vous pouvez utiliser _searchText pour effectuer la recherche
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _openQRScanner,
                child: const Text('Scanner un QR Code'),
              ),
              const SizedBox(height: 16.0),
              // Liste des produits
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Nombre d'éléments par ligne
                    crossAxisSpacing: 10, // Espace horizontal entre les éléments
                    mainAxisSpacing: 30, // Espace vertical entre les éléments
                    childAspectRatio: (170 / 220), // Ratio largeur/hauteur des enfants
                  ),
                  itemCount: _filteredProducts().length,
                  itemBuilder: (context, index) {
                    final Article product = _filteredProducts()[index];
                    return ArticleView(
                        article: product,
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(selectedTab: 1),
      floatingActionButton: const PanierFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
