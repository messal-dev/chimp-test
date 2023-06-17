import 'package:flutter/material.dart';

class BtnAction extends StatelessWidget {
  final String name;
  final Function()? onClick;

  const BtnAction(this.name, this.onClick, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: onClick == null ? Colors.grey.shade300 : Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            color: onClick == null ? Colors.grey : Colors.white,
          ),
        ),
      ),
    );
  }
}
