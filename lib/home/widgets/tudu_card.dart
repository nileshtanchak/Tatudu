import 'package:flutter/material.dart';

import '../../add_tudu/screens/add_tudu_screen.dart';
import '../../db_helper/db_helper.dart';
import '../../models/tudu.dart';
import '../../home/services/home_provider.dart';
import 'package:provider/provider.dart';

class TuduCard extends StatelessWidget {
  final Tudu tudu;
  final Function() onTap;
  final Function() onEdit;
  final Function() onDelete;

  const TuduCard({
    Key? key,
    required this.tudu,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    tudu.title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                InkWell(
                  onTap: onEdit,
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: onDelete,
                  child: Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.red.shade700,
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(
              tudu.desc,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
