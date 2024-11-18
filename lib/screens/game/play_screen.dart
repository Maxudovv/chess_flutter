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
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                  child: ValueListenableBuilder<Chess>(
                valueListenable: state.boardController,
                builder: (context, game, _) {
                  return ChessBoard(
                    controller: state.boardController,
                    boardColor: BoardColor.orange,
                    boardOrientation: PlayerColor.black,
                  );
                },
              )),
            ),
            if (state.status == GameStatus.finished)
            Expanded(
              flex: 1,
                child: Text(state.finishText)
            )
            // Expanded(
            //   flex: 1,
            //   child: ValueListenableBuilder<Chess>(
            //     valueListenable: state.boardController,
            //     builder: (context, game, _) {
            //       return Text(
            //         state.boardController.getSan().fold(
            //               '',
            //               (previousValue, element) {
            //                 return previousValue + '\n' + (element ?? '');
            //               }
            //
            //             ),
            //       );
            //     },
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
