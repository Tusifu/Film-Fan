import 'package:flutter/material.dart';

class TaskGroupContainer extends StatelessWidget {
  final MaterialColor color;
  final bool? isSmall;
  final IconData icon;
  final String taskGroup;
  final String taskCount;
  const TaskGroupContainer({
    Key? key,
    required this.color,
    this.isSmall = false,
    required this.icon,
    required this.taskGroup,
    required this.taskCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color[400],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: isSmall! ? Alignment.centerLeft : Alignment.center,
            child: Icon(
              icon,
              size: isSmall! ? 60 : 120,
              color: Colors.white,
            ),
          ),
          // const SizedBox(
          //   height: 15,
          // ),
          const Spacer(),
          Text(
            taskGroup,
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            taskCount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
