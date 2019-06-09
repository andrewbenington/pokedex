import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:pokedex/PokemonDetails.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int present = 0;
  int perPage = 30;
  Map<String, dynamic> jsonMap;

  List<PokemonIcon> tiles = <PokemonIcon>[];
  List<PokemonIcon> pokemon = <PokemonIcon>[];

  @override
  void initState() {
    super.initState();
    _generatePokemon();
  }

  void fillMap() async {
    final response = await get('https://pokeapi.co/api/v2/pokemon/?limit=807');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON

      jsonMap = json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load pokemon');
    }
  }

  void _generatePokemon() async {
    await fillMap();
    int index = 1;
    while (index < 810) {
      PokemonIcon icon = await _getPokemon(index);
      setState(() {
        pokemon.add(icon);
      });
      index++;
      if (index == perPage + 1) {
        tiles.addAll(pokemon.getRange(present, present + perPage));
        present = present + perPage;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: tiles == null || tiles.length < perPage
          ? Center(child: Text('loading...'))
          : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent) {
                  loadMore();
                }
              },
              child: GridView.count(
                children: tiles
                    .map(
                      (pokemon) => RaisedButton(
                            child: pokemon,
                            onPressed: () {
                              toDetails(pokemon.id);
                            },
                            color: Colors.white,
                          ),
                    )
                    .toList(),
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                padding: EdgeInsets.all(10.0),
              ),
            ),
      drawer: Drawer(),
    );
  }

  Future<PokemonIcon> _getPokemon(int dexnum) async {
    if (dexnum == 808) {
      return PokemonIcon(
          name: "Meltan",
          id: dexnum,
          url: "https://randompokemon.com/sprites/normal/808.gif");
    } else if (dexnum == 809) {
      return PokemonIcon(
          name: "Melmetal",
          id: dexnum,
          url: "https://randompokemon.com/sprites/normal/809.gif");
    } else {
      return PokemonIcon(
        name: jsonMap["results"][dexnum - 1]["name"],
        id: dexnum,
      );
    }
  }

  toDetails(int number) async {
    final creatureResponse =
        await get('https://pokeapi.co/api/v2/pokemon/' + number.toString());
    final speciesResponse = await get(
        'https://pokeapi.co/api/v2/pokemon-species/' + number.toString());

    if (speciesResponse.statusCode == 200 &&
        creatureResponse.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokemonDetails(
                creature: json.decode(creatureResponse.body),
                species: json.decode(speciesResponse.body),
              ),
        ),
      );
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  loadMore() {
    setState(() {
      if ((present + perPage) > pokemon.length) {
        tiles.addAll(pokemon.getRange(present, pokemon.length));

        present = pokemon.length;
      } else {
        tiles.addAll(pokemon.getRange(present, present + perPage));

        present = present + perPage;
      }
    });
  }
}

class PokemonIcon extends StatefulWidget {
  final String name;
  final int id;
  final String url;

  PokemonIcon({this.name, this.id, this.url});

  factory PokemonIcon.fromJson(
      Map<String, dynamic> species, Map<String, dynamic> creature) {
    String upperName = species["names"][2]["name"];
    Map<String, dynamic> sprites = creature["sprites"];

    return PokemonIcon(
        name: upperName, id: creature["id"], url: sprites["front_default"]);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PokemonIconState(
      name: name[0].toUpperCase() + name.substring(1),
      id: id,
      url: url,
    );
  }
}

class _PokemonIconState extends State<PokemonIcon> {
  String name;
  final int id;
  String url;
  Image image;

  _PokemonIconState({
    this.name,
    this.id,
    this.url,
  });

  @override
  initState() {
    super.initState();
    url = 'https://pokeapi.co/api/v2/pokemon/' + id.toString();
    loadName();
    loadImage();
  }

  loadName() async {
    final response =
        await get('https://pokeapi.co/api/v2/pokemon-species/' + id.toString());

    if (response.statusCode == 200) {
      name = json.decode(response.body)["names"][2]["name"];
      if (mounted) {
        setState(() {});
      }
    }
  }

  loadImage() async {
    final response =
        await get('https://pokeapi.co/api/v2/pokemon/' + id.toString());

    if (response.statusCode == 200 &&
        json.decode(response.body)["sprites"]["front_default"] != null) {
      String address = json.decode(response.body)["sprites"]["front_default"];
      image = Image.network(address, fit: BoxFit.fill);
      if (mounted) {
        setState(() {});
      }
    } else {
      image = Image.network(
          "https://randompokemon.com/sprites/normal/" + id.toString() + ".gif",
          fit: BoxFit.fill);
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return image != null
        ? Padding(
            child: Stack(
              children: <Widget>[
                Align(
                  child: Text(
                    id.toString(),
                  ),
                  alignment: Alignment.topLeft,
                ),
                Column(
                  children: <Widget>[
                    Expanded(
                      child: image,
                    ),
                    Align(
                      child: FittedBox(
                        child: Text(
                          name,
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                )
              ],
            ),
            padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
          )
        : Padding(
            child: Stack(
              children: <Widget>[
                Align(
                  child: Text(
                    id.toString(),
                  ),
                  alignment: Alignment.topLeft,
                ),
                Column(
                  children: <Widget>[
                    Spacer(),
                    Align(
                      child: FittedBox(
                        child: Text(
                          name,
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                )
              ],
            ),
            padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
          );
  }
}
