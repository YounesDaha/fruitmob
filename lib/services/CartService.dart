// ignore: unused_import
import 'package:flutter/material.dart';
import 'dart:async';

class CartService {
  static final List<Map<String, dynamic>> _cart = [];

  // Récupérer les éléments du panier
  static Future<List<Map<String, dynamic>>> fetchCartItems() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulation d'une requête
    return _cart;
  }

  // Ajouter un fruit au panier
  static Future<void> addItem(Map<String, dynamic> item) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulation de délai
    _cart.add(item);
  }

  // Supprimer un fruit du panier
  static Future<void> removeItem(Map<String, dynamic> item) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulation de délai
    _cart.remove(item);
  }
}
