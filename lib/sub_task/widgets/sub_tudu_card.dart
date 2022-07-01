import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatudu/models/sub_tudu.dart';
import 'package:tatudu/sub_task/services/sub_tudu_provider.dart';

class SubTuduCard extends StatelessWidget {
  final SubTudu subTudu;

  const SubTuduCard({
    Key? key,
    required this.subTudu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: CheckboxListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        dense: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subTudu.title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subTudu.desc,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ],
        ),
        value: subTudu.isCompleted,
        onChanged: (bool? value) {
          subTudu.isCompleted = value!;
          context
              .read<SubTuduProvider>()
              .updateSubTuduIsCompletedInDatabase(subTudu);
        },
      ),
    );
  }
}
