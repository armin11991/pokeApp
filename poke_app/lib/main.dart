import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red, // Change the primary color to red
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Pokémon'),
        ),
        body: RandomPokemonWidget(),
      ),
    );
  }
}

class RandomPokemonWidget extends StatefulWidget {
  @override
  _RandomPokemonWidgetState createState() => _RandomPokemonWidgetState();
}

class _RandomPokemonWidgetState extends State<RandomPokemonWidget> {
  String pokemonName = '';
  String imageUrl = '';

  Future<void> fetchRandomPokemon() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/${Random().nextInt(898) + 1}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        pokemonName = data['name'];
        imageUrl = data['sprites']['front_default'];
      });
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (imageUrl.isNotEmpty)
            Image.network(
              imageUrl,
              width: 150,
              height: 150,
            ),
          SizedBox(height: 20),
          Text(
            'Random Pokémon: $pokemonName',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: fetchRandomPokemon,
            child: Text('Get Random Pokémon'),
          ),
        ],
      ),
    );
  }
}

