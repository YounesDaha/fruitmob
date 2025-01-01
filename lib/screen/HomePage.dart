import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_6/screen/CartPage.dart';
import 'package:flutter_application_6/screen/FruitDetailPage.dart';
import 'package:flutter_application_6/screen/UserProfilePage.dart';

class FruitListPage extends StatefulWidget {
  const FruitListPage({super.key});

  @override
  State<FruitListPage> createState() => _FruitListPageState();
}

class _FruitListPageState extends State<FruitListPage> {
  int _currentIndex = 0;

  // Widget pour gérer les différentes pages
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return _buildBody();
      case 1:
        return const CartPage(); // Remplacez par votre page de panier
      case 2:
        return const UserProfilePage(); // Remplacez par votre page de profil
      default:
        return _buildBody();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0
            ? 'Acheter des Fruits'
            : _currentIndex == 1
                ? 'Mon Panier'
                : 'Mon Profil'),
        backgroundColor: Colors.green,
      ),
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Acheter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('fruit').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text('Aucun fruit disponible pour le moment.'));
        }

        final fruits = snapshot.data!.docs;

        return ListView.builder(
          itemCount: fruits.length,
          itemBuilder: (context, index) {
            final item = fruits[index];
            final data = item.data() as Map<String, dynamic>;

            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    data['image'] ?? 'URL_image_par_defaut',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      );
                    },
                  ),
                ),
                title: Text(
                  data['nom'] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'prix: ${data['prix']}€ / kg '),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FruitDetailPage(item: data),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}





