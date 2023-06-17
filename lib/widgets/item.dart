import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game_provider.dart';

class Item extends StatelessWidget {
  final GameModel item;

  const Item(this.item, {super.key});

  void _onClick(BuildContext ctx) {
    final provider = Provider.of<GameProvider>(ctx, listen: false);

    provider.checkAnswer(item);
  }

  @override
  Widget build(BuildContext context) {
    if (item.isCorrect == null) {
      return itemBuilder(context);
    } else if (item.isCorrect == false) {
      return errorItemBuilder();
    }

    return Container();
  }

  Widget errorItemBuilder() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.red),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        item.value.toString(),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }

  InkWell itemBuilder(BuildContext context) {
    final provider = Provider.of<GameProvider>(context, listen: false);

    return InkWell(
      onTap: (item.value > 0 && provider.isWin != false)
          ? () => _onClick(context)
          : null,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (item.value > 0 && !item.isShow) ? Colors.blue : Colors.white,
          border: (item.value > 0 && item.isShow)
              ? Border.all(width: 2, color: Colors.grey.shade300)
              : null,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: (item.value > 0 && item.isShow)
            ? Text(
                item.value.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              )
            : null,
      ),
    );
  }
}
