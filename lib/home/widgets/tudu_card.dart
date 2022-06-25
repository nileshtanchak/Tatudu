import 'package:flutter/material.dart';

import '../../add_tudu/screens/add_tudu_screen.dart';
import '../../db_helper/db_helper.dart';
import '../../models/tudu.dart';
import '../../home/services/home_provider.dart';
import 'package:provider/provider.dart';

class TuduCard extends StatelessWidget {
  final Tudu tudu;

  const TuduCard({Key? key, required this.tudu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTuduScreen(
                                tudu: tudu,
                                isEdit: true,
                              )));
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () async {
                  if (await context
                      .read<HomeProvider>()
                      .deleteTuduInDatabase(tudu)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text("Tudu : ${tudu.title} deleted successfully"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
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
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
