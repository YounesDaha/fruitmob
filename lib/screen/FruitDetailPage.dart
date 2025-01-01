import 'package:flutter/material.dart';
import '../services/CartService.dart';

class FruitDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const FruitDetailPage({Key? key, required this.item}) : super(key: key);

  Future<void> _addToCart(BuildContext context) async {
    await CartService.addItem(item);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fruit ajouté au panier')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['nom']),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image du fruit
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item['image'] ?? 'URL_image_par_defaut',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Nom du fruit
            Text(
              item['nom'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Prix et Origine
            Row(
              children: [
                Text(
                  'Prix: ${item['prix']}€ / kg',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 16),
                Text(
                  'Origine: ${item['origine']}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Bouton "Ajouter au panier"
            Center(
              child: ElevatedButton(
                onPressed: () => _addToCart(context),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 76, 86, 175)),
                child: const Text(
                  'Ajouter au panier',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
