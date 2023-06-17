import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/item.dart';
import './widgets/btn_action.dart';

import './game_provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  void _onStart() {
    final provider = Provider.of<GameProvider>(context, listen: false);
    provider.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Chimp Test')),
      body: Consumer<GameProvider>(
        builder: (ctx, provider, _) {
          return Column(
            children: [
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.7,
                child: GridView(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  children: provider.items.map((item) => Item(item)).toList(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(children: [
                    if (provider.isWin != null) statusResultBuilder(provider),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // High Level
                        resultLevelBuilder('High Level: ', provider.highLevel),
                        // Current Level
                        resultLevelBuilder('Level: ', provider.level)
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    BtnAction(
                      (provider.isWin == null || provider.isSuccess)
                          ? 'Start'
                          : provider.isWin == true
                              ? 'Continue'
                              : 'Restart',
                      provider.isPlay == true ? null : _onStart,
                    ),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Text statusResultBuilder(GameProvider provider) {
    String status = 'You Win';
    if (provider.isSuccess == true) {
      status = 'Congratulation you are the winner.';
    } else {
      if (provider.isWin == false) {
        status = 'You Lost';
      }
    }

    return Text(
      status,
      style: TextStyle(
        fontSize: 16,
        color: provider.isWin == true ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Row resultLevelBuilder(String name, int level) {
    return Row(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          level.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
