import 'package:flutter/material.dart';

final cityTextStyle = TextStyle(
    shadows: <Shadow>[
      Shadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 1,
          offset: const Offset(-2, 3))
    ],
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
    fontFamily: 'Overpass');

final currentDayTextStyle = TextStyle(
    shadows: <Shadow>[
      Shadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 1,
          offset: const Offset(-2, 3))
    ],
    color: Colors.white,
    fontSize: 18,
    letterSpacing: 1.0,
    fontFamily: 'Overpass');

final tempTextStyle = TextStyle(
    shadows: <Shadow>[
      Shadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(-4, 6))
    ],
    color: Colors.white,
    fontSize: 90,
    letterSpacing: 2,
    fontFamily: 'Overpass',
    fontWeight: FontWeight.normal);
