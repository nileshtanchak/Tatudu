import 'package:flutter/material.dart';
import 'package:tatudu/models/sub_tudu.dart';
import 'package:tatudu/sub_task/services/sub_tudu_provider.dart';

import '../../widgets/custom_text_form_field.dart';
import '../../widgets/text_button.dart';
import 'package:provider/provider.dart';

class AddSubTuduScreen extends StatefulWidget {
  final int parentTuduId;

  const AddSubTuduScreen({Key? key, required this.parentTuduId})
      : super(key: key);

  @override
  State<AddSubTuduScreen> createState() => _AddSubTuduScreenState();
}

class _AddSubTuduScreenState extends State<AddSubTuduScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Sub Tudu"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: _nameController,
                label: "Title",
                hintText: "Enter title",
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _descController,
                label: "Description",
                hintText: "Enter description",
                singleLine: false,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomTextButton(
          onTap: _onSaveTap,
          label: "Save",
        ),
      ),
    );
  }

  void _onSaveTap() async {
    SubTudu subTudu = SubTudu(
      parentTuduId: widget.parentTuduId,
      title: _nameController.text.trim(),
      desc: _descController.text.trim(),
    );
    if (await context.read<SubTuduProvider>().addSubTuduToDatabase(subTudu)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("SubTudu added successfully"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
