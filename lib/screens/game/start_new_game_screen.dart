import 'package:auto_route/auto_route.dart';
import 'package:chess_frontend/screens/game/cubit/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class StartNewGameScreen extends StatelessWidget {
  const StartNewGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<GameCubit, GameState>(
        listener: (context, state) {
          if (state.status == GameStatus.inProgress) {
            context.router.replaceNamed("/play");
          }
        },
        child: Center(
            child: ElevatedButton(
                onPressed: () {
                  context.read<GameCubit>().startNewGame();
                },
                child: const Text("Начать игру")
            )
        ),
      ),
    );
  }
}
