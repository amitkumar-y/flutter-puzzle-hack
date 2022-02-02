import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roll_the_ball/screens/puzzle/blocs/ball/ball_bloc.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc() : super(PuzzleInitial()) {
    on<Swipe>(_swipe);
  }

  List<List<int>> level1 = [
    [0, 0, 0, 0],
    [0, 5, 14, 19],
    [0, 17, 0, 2],
    [0, 0, 18, 0],
  ];

  List<List<int>> level1Win = [
    [0, 0, 0, 0],
    [0, 5, 14, 19],
    [0, 17, 18, 2],
    [0, 0, 0, 0],
  ];

  final sound = AudioCache();

  _swipe(Swipe event, Emitter<PuzzleState> emit) {
    Direction direction = event.direction;
    int i = event.row;
    int j = event.column;

    switch (direction) {
      case Direction.up:
        level1[i - 1][j] = level1[i][j];
        break;
      case Direction.down:
        level1[i + 1][j] = level1[i][j];
        break;
      case Direction.left:
        level1[i][j - 1] = level1[i][j];
        break;
      case Direction.right:
        level1[i][j + 1] = level1[i][j];
        break;
    }

    level1[i][j] = 0;

    sound.play('audio/tile.mp3', volume: 0.5);
    emit(TileMoved());

    if (const DeepCollectionEquality().equals(level1, level1Win)) {
      BlocProvider.of<BallBloc>(event.context).add(RollBall());
    }
  }
}

enum Direction {
  up,
  down,
  left,
  right,
}