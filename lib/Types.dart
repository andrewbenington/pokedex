import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Type {
  Type({this.weak, this.resistant, this.immune, this.icon, this.color});
  List<String> weak;
  List<String> resistant;
  List<String> immune;
  String icon;
  Color color;
}

Type grass = Type(
  weak: ["bug", "fire", "flying", "ice", "poison"],
  resistant: ["electric", "grass", "ground", "water"],
  immune: [],
  icon: "assets/Icon_Grass.png",
  color: Colors.green,
);

Type water = Type(
  weak: ["electric", "grass"],
  resistant: ["fire", "ice", "steel", "water"],
  immune: [],
  icon: "assets/Icon_Water.png",
  color: Colors.blue,
);

Type fire = Type(
  weak: ["water", "ground", "rock"],
  resistant: ["bug", "fairy", "fire", "grass", "ice", "steel"],
  immune: [],
  icon: "assets/Icon_Fire.png",
  color: Colors.red,
);

Type rock = Type(
  weak: ["fighting", "grass", "ground", "steel", "water"],
  resistant: ["fire", "flying", "normal", "poison"],
  immune: [],
  icon: "assets/Icon_Rock.png",
  color: Colors.brown[300],
);

Type ground = Type(
  weak: ["grass", "ice", "water"],
  resistant: ["poison", "rock"],
  immune: ["electric"],
  icon: "assets/Icon_Ground.png",
  color: Colors.brown,
);

Type electric = Type(
  weak: ["ground"],
  resistant: ["electric", "flying", "steel"],
  immune: [],
  icon: "assets/Icon_Electric.png",
  color: Colors.yellow,
);

Type dragon = Type(
  weak: ["dragon", "fairy", "ice"],
  resistant: ["electric", "fire", "grass", "water"],
  immune: [],
  icon: "assets/Icon_Dragon.png",
  color: Colors.deepPurple,
);

Type steel = Type(
  weak: ["fighting", "fire", "ground"],
  resistant: ["bug", "dragon", "fairy", "flying", "ice", "normal", "psychic", "rock", "steel"],
  immune: ["poison"],
  icon: "assets/Icon_Steel.png",
  color: Colors.blueGrey[300],
);

Type ice = Type(
  weak: ["fighting", "fire", "rock", "steel"],
  resistant: ["ice"],
  immune: [],
  icon: "assets/Icon_Ice.png",
  color: Colors.lightBlue,
);

Type flying = Type(
  weak: ["electric", "ice", "rock"],
  resistant: ["bug", "fighting", "grass"],
  immune: ["ground"],
  icon: "assets/Icon_Flying.png",
  color: Colors.deepPurple[200],
);

Type fighting = Type(
  weak: ["fairy", "flying", "psychic"],
  resistant: ["bug", "dark", "rock"],
  immune: [],
  icon: "assets/Icon_Fighting.png",
  color: Colors.red[500],
);

Type fairy = Type(
  weak: ["poison", "steel"],
  resistant: ["bug", "dark", "fighting"],
  immune: ["dragon"],
  icon: "assets/Icon_Fairy.png",
  color: Colors.pink[200],
);

Type poison = Type(
  weak: ["ground", "psychic"],
  resistant: ["fighting", "poison", "bug", "grass", "fairy"],
  immune: ["steel"],
  icon: "assets/Icon_Poison.png",
  color: Colors.purple[300],
);

Type normal = Type(
  weak: ["fighting"],
  resistant: [],
  immune: ["ghost"],
  icon: "assets/Icon_Normal.png",
  color: Colors.brown[100],
);

Type ghost = Type(
  weak: ["dark", "ghost"],
  resistant: ["bug", "poison"],
  immune: ["normal", "fighting"],
  icon: "assets/Icon_Ghost.png",
  color: Colors.deepPurple[300],
);

Type psychic = Type(
  weak: ["bug", "dark", "ghost"],
  resistant: ["psychic", "fighting"],
  immune: [],
  icon: "assets/Icon_Psychic.png",
  color: Colors.pink[300],
);

Type dark = Type(
  weak: ["ghost", "psychic"],
  resistant: ["dark", "fighting", "steel"],
  immune: [],
  icon: "assets/Icon_Dark.png",
  color: Colors.black87,
);

Type bug = Type(
  weak: ["bug", "fairy", "fighting"],
  resistant: ["dark", "ghost"],
  immune: ["psychic"],
  icon: "assets/Icon_Bug.png",
  color: Colors.lightGreen,
);

Map<String, Type> typeMap = {
  "ice": ice,
  "fire": fire,
  "water": water,
  "poison": poison,
  "psychic": psychic,
  "normal": normal,
  "electric": electric,
  "ghost": ghost,
  "dark": dark,
  "dragon": dragon,
  "fairy": fairy,
  "fighting": fighting,
  "grass": grass,
  "bug": bug,
  "steel": steel,
  "flying": flying,
  "rock": rock,
  "ground": ground
};
