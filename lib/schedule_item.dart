import 'package:flutter/material.dart';
import 'home_page.dart';

class ScheduleItem extends StatelessWidget {
  final Schedule schedule;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ScheduleItem({required this.schedule, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          "${schedule.subject} - ${schedule.type}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${schedule.date} at ${schedule.time}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: onEdit),
            IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}