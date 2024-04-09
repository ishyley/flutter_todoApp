import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskname;
  final bool taskComplete;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? shareFunction;

  ToDoTile(
      {super.key,
      required this.taskname,
      required this.taskComplete,
      required this.onChanged,
      required this.deleteFunction,
      required this.shareFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red,
          ),
        ]),
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: shareFunction,
              icon: Icons.share,
              backgroundColor: Colors.blue,
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                value: taskComplete,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Text(
                taskname,
                style: TextStyle(
                    decoration: taskComplete
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
