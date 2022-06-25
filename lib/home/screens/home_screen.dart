import 'package:flutter/material.dart';

import '../../add_tudu/screens/add_tudu_screen.dart';
import '../../db_helper/db_helper.dart';
import '../../models/tudu.dart';
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
                          );
                        },
                        separatorBuilder: (_, index) {
                          return SizedBox(
                            height: 10,
                          );
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
