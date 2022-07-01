import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatudu/models/tudu.dart';
import 'package:tatudu/sub_task/services/sub_tudu_provider.dart';
import 'package:tatudu/utils/colors.dart';

import '../widgets/sub_tudu_card.dart';
import '../widgets/tudu_details_header.dart';
import 'add_sub_tudu_screen.dart';

class TuduDetailsScreen extends StatelessWidget {
  final Tudu tudu;

  const TuduDetailsScreen({Key? key, required this.tudu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tudu Details",
        ),
      ),
      body: Column(
        children: [
          TuduDetailsHeader(tudu: tudu),
          Container(
            width: double.infinity,
            color: AppColor.primaryColor,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Sub Tasks",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: context
                  .read<SubTuduProvider>()
                  .getAllTudusFromDatabase(tudu.id.toString()),
              builder: (_, __) {
                return Consumer<SubTuduProvider>(
                  builder: (_, provider, __) {
                    return provider.subTuduList.isEmpty
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "List is empty\n\n You can create a new Sub Tudu by taping on below add button.",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade500),
                              textAlign: TextAlign.center,
                            ),
                          ))
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 10)
                                .copyWith(bottom: 100),
                            itemCount: provider.subTuduList.length,
                            itemBuilder: (_, index) {
                              return SubTuduCard(
                                subTudu: provider.subTuduList[index],
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const SizedBox(height: 10);
                            },
                          );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddSubTuduScreen(
                        parentTuduId: tudu.id,
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
