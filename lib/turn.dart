import 'package:beret/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Turn extends StatelessWidget {
  Widget build(BuildContext context) {
    final currentState = Provider.of<AppState>(context).gameState;

    return Scaffold(
            appBar: AppBar(
              title: Text('Шляпа'),
            ),
            body: Observer(builder: (_) {
              if (currentState.state == 'end') {
                return EndGame();
              } else if (currentState.state == 'main') {
                return Stack(children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        currentState.timer.toString(),
                        style: TextStyle(fontSize: 30),
                      )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ErrorButton(),
                            ConcedeButton(),
                            GuessedRightButton()
                          ])),
                  Center(child: CurrentWord())
                ]);
              } else if (currentState.state == 'last') {
                return Stack(children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: Text(
                          (currentState.timer + currentState.lastStateLength)
                              .toString(),
                          style: TextStyle(fontSize: 30, color: Colors.red))),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ErrorButton(),
                            GuessedWrongButton(),
                            GuessedRightButton()
                          ])),
                  Center(child: CurrentWord())
                ]);
              } else if (currentState.state == 'verdict') {
                return Stack(children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: Text('0',
                          style: TextStyle(fontSize: 30, color: Colors.red))),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ErrorButton(),
                            GuessedWrongButton(),
                            GuessedRightButton()
                          ])),
                  Center(child: CurrentWord())
                ]);
              } else {
                return Stack(children: <Widget>[
                  Center(
                      child: SizedBox(
                          width: 200.0,
                          height: 100.0,
                          child: PlayersDisplay())),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GameStartButton(),
                  )
                ]);
              }
            }));
  }
}

class PlayersDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = Provider.of<AppState>(context).gameState;

    return Observer(
        builder: (_) =>
            Stack(children: <Widget>[
              Align(
                  alignment: Alignment.bottomRight,
                  child: Text(currentState.playerTwo)),
              Align(
                alignment: Alignment.topLeft,
                child: Text(currentState.playerOne),
              )
            ]));
  }
}

class GameStartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = Provider.of<AppState>(context).gameState;

    return RaisedButton(
        onPressed: () {
          currentState.newTurn();
        },
        child: Text('Поехали', style: TextStyle(fontSize: 20)));
  }
}

class GuessedRightButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = Provider.of<AppState>(context).gameState;

    return RaisedButton(
      onPressed: () {
        currentState.guessedRight();
      },
      child: Text('Угадано', style: TextStyle(fontSize: 20)),
    );
  }
}

class GuessedWrongButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = Provider
        .of<AppState>(context)
        .gameState;

    return RaisedButton(
      onPressed: () {
        currentState.concede();
      },
      child: Text('Не угадано', style: TextStyle(fontSize: 20)),
    );
  }
}

class ConcedeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = Provider
        .of<AppState>(context)
        .gameState;

    return RaisedButton(
      onPressed: () {
        currentState.concede();
      },
      child: Text('Сдаться', style: TextStyle(fontSize: 20)),
    );
  }
}

class ErrorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = Provider
        .of<AppState>(context)
        .gameState;

    return RaisedButton(
      onPressed: () {
        currentState.error();
      },
      child: Text('Ошибка', style: TextStyle(fontSize: 20, color: Colors.red)),
    );
  }
}

class CurrentWord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = Provider.of<AppState>(context).gameState;

    return Observer(
        builder: (_) =>
            Text(currentState.word, style: TextStyle(fontSize: 40)));
  }
}

class EndGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Center(
        child: Column(children: <Widget>[
          RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Закончить игру', style: TextStyle(fontSize: 20)))
        ]));
}
