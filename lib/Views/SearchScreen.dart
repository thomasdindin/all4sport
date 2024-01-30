import 'package:all4sport/Views/Components/BottomBar.dart';
import 'package:all4sport/Views/Components/PanierFab.dart';
import 'package:all4sport/Views/QRScanScreen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  String _selectedFilter = 'Tous';

  final List<String> _products = [
    'Produit 1',
    'Produit 2',
    'Produit 3',
    // Ajoutez ici la liste de vos produits
  ];

  List<String> _filteredProducts() {
    if (_selectedFilter == 'Tous') {
      return _products;
    } else {
      return _products.where((product) {
        // Appliquez ici la logique de filtrage selon le filtre sélectionné
        // Par exemple, si le filtre est "Filtre 1", renvoyez true pour les produits qui correspondent à ce filtre
        return true;
      }).toList();
    }
  }

  void _openQRScanner() {
    // Ouvrir une nouvelle page ou un dialogue pour le scanner
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QRScanPage()));
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
                child: Text('Scanner un QR Code'),
              ),
              const SizedBox(height: 16.0),
              // Liste des produits
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredProducts().length,
                  itemBuilder: (context, index) {
                    final product = _filteredProducts()[index];
                    return ListTile(
                      title: Text(product),
                      // Ajoutez ici la mise en page des produits
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(selectedTab: 1),
      floatingActionButton: PanierFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
