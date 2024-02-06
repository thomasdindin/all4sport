import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int selectedTab;
  const BottomBar({Key? key, required this.selectedTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Définissez les couleurs pour l'icône sélectionnée et non sélectionnée
    const Color selectedColor = Colors.deepOrange; // Couleur pour l'onglet sélectionné
    const Color unselectedColor = Colors.black; // Couleur pour les onglets non sélectionnés

    // Fonction pour créer chaque bouton
    Widget _buildTabItem({
      required IconData icon,
      required String text,
      required int index,
      required VoidCallback onPressed,
    }) {
      Color color = selectedTab == index ? selectedColor : unselectedColor;

      return InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Text(text, style: TextStyle(color: color)),
          ],
        ),
      );
    }

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildTabItem(
              icon: Icons.home,
              text: 'Accueil',
              index: 0,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
            _buildTabItem(
              icon: Icons.search,
              text: 'Rechercher',
              index: 1,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/recherche', (route) => false);
              },
            ),
            _buildTabItem(
              icon: Icons.person,
              text: 'Profil',
              index: 2,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
