import 'package:auto_route/auto_route.dart';
import 'package:chess_frontend/screens/game/cubit/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


@RoutePage()
class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Center(
          child: Text("Game id ${state.gameId}"),
        );
      },
    );
  }
}
