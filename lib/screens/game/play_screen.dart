import 'package:auto_route/auto_route.dart';
import 'package:chess_frontend/screens/game/cubit/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';


@RoutePage()
class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ValueListenableBuilder<Chess>(
          valueListenable: context.read<GameCubit>().state.boardController,
          builder: (context, game, _) {
            return ChessBoard(
              controller: context.read<GameCubit>().state.boardController,
              boardColor: BoardColor.orange,
              boardOrientation: PlayerColor.black,
            );
          },
        )
    );
  }
}
