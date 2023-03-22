import 'package:flutter/material.dart';

class Keys {
  static EdgeInsetsGeometry pagePadding = const EdgeInsets.all(15);
  static Color primaryColor = Colors.blue;
  static Color secondaryColor = const Color.fromARGB(255, 149, 117, 205);
  static Color tertiaryColor = Colors.blue.shade300;
  static var chartData = [];
  static var transactionType = {
    'Food': const Icon(
      Icons.restaurant,
      color: Colors.white,
      size: 30,
    ),
    'Housing': const Icon(
      Icons.home,
      color: Colors.white,
      size: 30,
    ),
    'Education': const Icon(
      Icons.school,
      color: Colors.white,
      size: 30,
    ),
    'Entertainment': const Icon(
      Icons.sports_esports,
      color: Colors.white,
      size: 30,
    ),
    'Gift': const Icon(
      Icons.redeem,
      color: Colors.white,
      size: 30,
    ),
    'Healthcare': const Icon(
      Icons.medical_services,
      color: Colors.white,
      size: 30,
    ),
    'Transportation': const Icon(
      Icons.commute,
      color: Colors.white,
      size: 30,
    ),
    'Income': const Icon(
      Icons.paid,
      color: Colors.white,
      size: 30,
    ),
    'Miscellanous': const Icon(
      Icons.credit_card,
      color: Colors.white,
      size: 30,
    )
  };
  static Map<String, String> currencies = {
    'Dollar': '\$',
    'Euro': '€',
    'Pound': '£',
    'Yuan': '¥',
    'Cedi': '¢',
    'Ruble': '₽',
    'Naira': '₦',
    'Won': '₩',
  };
}
