import 'package:flutter/material.dart';
import 'package:tatudu/sub_task/screens/tudu_details_screen.dart';

import '../../add_tudu/screens/add_tudu_screen.dart';
import '../../home/services/home_provider.dart';
import '../../home/widgets/tudu_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tatudu"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: context.read<HomeProvider>().getAllTudusFromDatabase(),
          builder: (_, __) {
            return Consumer<HomeProvider>(
              builder: (_, provider, __) {
                return provider.tuduList.isEmpty
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "List is empty\n\n You can create a new Tudu by taping on below add button.",
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade500),
                          textAlign: TextAlign.center,
                        ),
                      ))
                    : ListView.separated(
                        padding: const EdgeInsets.all(16).copyWith(bottom: 100),
                        itemCount: provider.tuduList.length,
                        itemBuilder: (_, index) {
                          return TuduCard(
                            tudu: provider.tuduList[index],
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TuduDetailsScreen(
                                            tudu: provider.tuduList[index],
                                          )));
                            },
                            onEdit: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddTuduScreen(
                                            tudu: provider.tuduList[index],
                                            isEdit: true,
                                          )));
                            },
                            onDelete: () async {
                              if (await context
                                  .read<HomeProvider>()
                                  .deleteTuduInDatabase(
                                      provider.tuduList[index])) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Tudu : ${provider.tuduList[index].title} deleted successfully"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTuduScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
