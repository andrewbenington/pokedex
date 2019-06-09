import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pokedex/Types.dart';

import 'dart:convert';

class PokemonDetails extends StatefulWidget {
  final Map<String, dynamic> creature;
  final Map<String, dynamic> species;
  PokemonDetails({
    Key key,
    this.title,
    this.creature,
    this.species,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _PokemonDetailsState(
      number: creature["id"],
      name: species["names"][2]["name"],
      types: creature["types"],
      formes: species["varieties"],
    );
  }
}

class _PokemonDetailsState extends State<PokemonDetails> {
  _PokemonDetailsState({
    this.number,
    this.name,
    this.types,
    this.formes,
  });

  @override
  void initState() {
    super.initState();
    loadTypes();
  }

  final int number;
  final String name;
  final List<dynamic> types;
  final List<dynamic> formes;

  Type type1;
  Type type2;

  List<Type> weak = <Type>[];
  List<Type> doubleWeak = <Type>[];
  List<Type> resistant = <Type>[];
  List<Type> doubleResistant = <Type>[];
  List<Type> immune = <Type>[];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Card(
            child: DecoratedBox(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: "No. " + number.toString() + ":",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textScaleFactor: 1.5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textScaleFactor: 1.5,
                        ),
                        Expanded(
                          child: type2 != null
                              ? Row(
                                  children: <Widget>[
                                    Image.asset(
                                      type1.icon,
                                      scale: 1.5,
                                    ),
                                    Image.asset(
                                      type2.icon,
                                      scale: 1.5,
                                    ),
                                  ],
                                )
                              : Image.asset(type1.icon),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        child: Image.network(
                            "https://randompokemon.com/sprites/normal/" +
                                number.toString() +
                                ".gif",
                            fit: BoxFit.contain),
                        height: MediaQuery.of(context).size.height * .2,
                      ),
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height * .2,
                padding: EdgeInsets.all(10.0),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    type1.color,
                    type2 == null ? type1.color : type2.color,
                  ],
                ),
              ),
            ),
            margin: EdgeInsets.all(5.0),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Card(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Card(
                          child: Container(
                            child: RichText(
                              text: TextSpan(
                                text: "Weak x2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              textScaleFactor: 1.5,
                            ),
                            margin: EdgeInsets.all(2.0),
                          ),
                          color: Colors.red[400],
                        ),
                        Spacer(),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: weak.length != 0
                              ? weak
                                  .map(
                                    (weakType) => CircleAvatar(
                                          child: Image.asset(weakType.icon,
                                              fit: BoxFit.fill),
                                          backgroundColor: weakType.color,
                                        ),
                                  )
                                  .toList()
                              : <Widget>[
                                  Card(
                                    child: Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "NONE",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        textScaleFactor: 1.5,
                                      ),
                                      margin: EdgeInsets.all(2.0),
                                    ),
                                    color: Colors.black,
                                  ),
                                ],
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(5.0),
                  ),
                  color: type1.color,
                  margin: EdgeInsets.all(5.0),
                ),
                Card(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Card(
                          child: Container(
                            child: RichText(
                              text: TextSpan(
                                text: "Weak x4",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              textScaleFactor: 1.5,
                            ),
                            margin: EdgeInsets.all(2.0),
                          ),
                          color: Colors.red[400],
                        ),
                        Spacer(),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: doubleWeak.length != 0
                              ? doubleWeak
                                  .map(
                                    (weakType) => CircleAvatar(
                                          child: Image.asset(weakType.icon,
                                              fit: BoxFit.fill),
                                          backgroundColor: weakType.color,
                                        ),
                                  )
                                  .toList()
                              : <Widget>[
                                  Card(
                                    child: Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "NONE",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        textScaleFactor: 1.5,
                                      ),
                                      margin: EdgeInsets.all(2.0),
                                    ),
                                    color: Colors.black,
                                  ),
                                ],
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(5.0),
                  ),
                  color: type1.color,
                  margin: EdgeInsets.all(5.0),
                ),
                Card(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Card(
                          child: Container(
                            child: RichText(
                              text: TextSpan(
                                text: "Resistant x2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              textScaleFactor: 1.5,
                            ),
                            margin: EdgeInsets.all(2.0),
                          ),
                          color: Colors.green[400],
                        ),
                        Expanded(
                          child: Align(
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: resistant.length != 0
                                  ? resistant
                                      .map(
                                        (resType) => CircleAvatar(
                                              child: Image.asset(resType.icon,
                                                  fit: BoxFit.fill),
                                              backgroundColor: resType.color,
                                            ),
                                      )
                                      .toList()
                                  : <Widget>[
                                      Card(
                                        child: Container(
                                          child: RichText(
                                            text: TextSpan(
                                              text: "NONE",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            textScaleFactor: 1.5,
                                          ),
                                          margin: EdgeInsets.all(2.0),
                                        ),
                                        color: Colors.black,
                                      ),
                                    ],
                              alignment: WrapAlignment.end,
                            ),
                            alignment: Alignment.centerRight,
                          ),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(5.0),
                  ),
                  color: type1.color,
                  margin: EdgeInsets.all(5.0),
                ),
                Card(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Card(
                          child: Container(
                            child: RichText(
                              text: TextSpan(
                                text: "Resistant x4",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              textScaleFactor: 1.5,
                            ),
                            margin: EdgeInsets.all(2.0),
                          ),
                          color: Colors.green[400],
                        ),
                        Spacer(),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: doubleResistant.length != 0
                              ? doubleResistant
                                  .map(
                                    (resType) => CircleAvatar(
                                          child: Image.asset(resType.icon,
                                              fit: BoxFit.fill),
                                          backgroundColor: resType.color,
                                        ),
                                  )
                                  .toList()
                              : <Widget>[
                                  Card(
                                    child: Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "NONE",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        textScaleFactor: 1.5,
                                      ),
                                      margin: EdgeInsets.all(2.0),
                                    ),
                                    color: Colors.black,
                                  ),
                                ],
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(5.0),
                  ),
                  color: type1.color,
                  margin: EdgeInsets.all(5.0),
                ),
                Card(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Card(
                          child: Container(
                            child: RichText(
                              text: TextSpan(
                                text: "Immune",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              textScaleFactor: 1.5,
                            ),
                            margin: EdgeInsets.all(2.0),
                          ),
                          color: Colors.blue[400],
                        ),
                        Spacer(),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: immune.length != 0
                              ? immune
                                  .map(
                                    (resType) => CircleAvatar(
                                          child: Image.asset(resType.icon,
                                              fit: BoxFit.fill),
                                          backgroundColor: resType.color,
                                        ),
                                  )
                                  .toList()
                              : <Widget>[
                                  Card(
                                    child: Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "NONE",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        textScaleFactor: 1.5,
                                      ),
                                      margin: EdgeInsets.all(2.0),
                                    ),
                                    color: Colors.black,
                                  ),
                                ],
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(5.0),
                  ),
                  color: type1.color,
                  margin: EdgeInsets.all(5.0),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('√'),
        onPressed: () {},
      ),
    );
  }

  loadTypes() {
    String name = types[0]["type"]["name"];
    print(typeMap["fairy"]);
    type1 = typeMap[name];
    for (String t in type1.weak) {
      weak.add(typeMap[t]);
    }
    for (String t in type1.resistant) {
      resistant.add(typeMap[t]);
    }
    for (String t in type1.immune) {
      immune.add(typeMap[t]);
    }
    if (types.length > 1) {
      type2 = typeMap[types[1]["type"]["name"]];
      for (String t in type2.weak) {
        if (weak.indexOf(typeMap[t]) != -1) {
          doubleWeak.add(typeMap[t]);
          weak.remove(typeMap[t]);
        } else if (resistant.indexOf(typeMap[t]) != -1) {
          resistant.remove(typeMap[t]);
        } else if (immune.indexOf(typeMap[t]) == -1) {
          weak.add(typeMap[t]);
        }
      }
      for (String t in type2.resistant) {
        if (weak.indexOf(typeMap[t]) != -1) {
          resistant.remove(typeMap[t]);
        } else if (resistant.indexOf(typeMap[t]) != -1) {
          doubleResistant.add(typeMap[t]);
          resistant.remove(typeMap[t]);
        } else if (immune.indexOf(typeMap[t]) == -1) {
          resistant.add(typeMap[t]);
        }
      }
      for (String t in type2.immune) {
        if (weak.indexOf(typeMap[t]) != -1) {
          weak.remove(typeMap[t]);
        } else if (resistant.indexOf(typeMap[t]) != -1) {
          resistant.remove(typeMap[t]);
        } else if (immune.indexOf(typeMap[t]) == -1) {
          immune.add(typeMap[t]);
        }
      }
    }
  }
}
