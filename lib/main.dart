import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
  title: 'Adventure Game',
  home: AdventureGame(),
));

class Room {
  final String name;
  final String description;
  final String directionNorth;
  final String directionEast;
  final String directionSouth;
  final String directionWest;

  Room({
    required this.name,
    required this.description,
    required this.directionNorth,
    required this.directionEast,
    required this.directionSouth,
    required this.directionWest,
  });
}

class AdventureGame extends StatefulWidget {
  @override
  _AdventureGameState createState() => _AdventureGameState();
}

class _AdventureGameState extends State<AdventureGame> {
  int _currentRoomIndex = 0;
  final List<Room> _rooms = [
    Room(
      name: 'Entry Hall',
      description: 'You are in the Entry Hall. You find yourself in a grand space with a chandelier hanging from the ceiling. You hear the sound of silverware clinking in the east and a faint aroma of old books wafts from the south.',
      directionEast: 'Dining Room',
      directionSouth: 'Library',
      directionNorth:'',
      directionWest: '',
    ),
    Room(
      name: 'Dining Room',
      description: 'You are in the Dining Room. This room is elegantly set for a formal dinner, but there is no one in sight. For culinary secrets, venture south. West is where the story began.',
      directionNorth: '',
      directionWest: 'Entry Hall',
      directionSouth: 'Kitchen',
      directionEast: '',
    ),
    Room(
      name: 'Library',
      description: 'You are in the Library. Shelves upon shelves of old books line the walls. A room of dusty papers and intriguing revelations going east. A draft of cold air comes from the south.',
      directionNorth: 'Entry Hall',
      directionEast: 'Study',
      directionSouth: 'Garden',
      directionWest: '',
    ),
    Room(
      name: 'Kitchen',
      description: 'You are in the Kitchen. This room smells of freshly baked bread, but there is no one here.The sound of clinking silverware grows louder to the north, suggesting a place where meals might be enjoyed. ',
      directionNorth: 'Dining Room',
      directionEast: '',
      directionSouth: '',
      directionWest: '',
    ),
    Room(
      name: 'Study',
      description: 'You are in the Study room. A desk covered in dusty papers and a large leather chair dominates the room. To uncover more mysteries, seek the knowledge hidden in the door going west.',
      directionNorth: '',
      directionEast: '',
      directionSouth: '',
      directionWest: 'Library',
    ),
    Room(
      name: 'Garden',
      description: 'You step into a serene garden with a beautiful fountain in the center. A room full of adventures going north.',
      directionNorth: 'Library',
      directionEast: '',
      directionSouth: '',
      directionWest: '',
    ),
  ];

  void _navigate(String direction) {
    setState(() {
      String nextRoomDirection;
      switch (direction) {
        case 'North':
          nextRoomDirection = _rooms[_currentRoomIndex].directionNorth;
          break;
        case 'East':
          nextRoomDirection = _rooms[_currentRoomIndex].directionEast;
          break;
        case 'South':
          nextRoomDirection = _rooms[_currentRoomIndex].directionSouth;
          break;
        case 'West':
          nextRoomDirection = _rooms[_currentRoomIndex].directionWest;
          break;
        default:
          nextRoomDirection = '';
          break;
      }

      int nextRoomIndex = _rooms.indexWhere((room) => room.name == nextRoomDirection);

      if (nextRoomIndex != -1) {
        _currentRoomIndex = nextRoomIndex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Room currentRoom = _rooms[_currentRoomIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Adventure Game'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Room: ${currentRoom.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              currentRoom.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (currentRoom.directionNorth.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      _navigate('North');
                    },
                    child: Text('Go North'),
                  ),
                if (currentRoom.directionEast.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      _navigate('East');
                    },
                    child: Text('Go East'),
                  ),
                if (currentRoom.directionSouth.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      _navigate('South');
                    },
                    child: Text('Go South'),
                  ),
                if (currentRoom.directionWest.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      _navigate('West');
                    },
                    child: Text('Go West'),
                  ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else {
                  exit(0);
                }
              },
              child: Text('Exit The Game'),
            ),
          ],
        ),
      ),
    );
  }
}
