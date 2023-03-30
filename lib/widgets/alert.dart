import 'package:flutter/material.dart';

class CreateAlert extends StatefulWidget {
  final String title;
  final String content;
  final Function function;
  const CreateAlert(
      {super.key,
      required this.title,
      required this.content,
      required this.function});

  @override
  State<CreateAlert> createState() => _CreateAlertState();
}

class _CreateAlertState extends State<CreateAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text(
            "NO",
            style: TextStyle(),
          ),
        ),
        TextButton(
            onPressed: () {
              widget.function();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text("YES", style: TextStyle(color: Colors.red))),
      ],
    );
  }
}
