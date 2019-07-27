import 'package:beret/turn.dart';
import 'package:flutter/material.dart';
import 'package:beret/game_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


class Match extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = Provider.of<GameState>(context);

    return Observer(
      builder: (_) => Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                currentState.refresh();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Turn()),
                );
              },
              child: Text('Начать игру', style: TextStyle(fontSize: 20))
            ),
            SettingsInfo()
          ]
        )
      )
    );
  }
}

class SettingsInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = Provider.of<GameState>(context);

    return Observer(
      builder: (_) => Text('Всего слов в шляпе: ' + currentState.hatSize.toString())
    );
  }
}
