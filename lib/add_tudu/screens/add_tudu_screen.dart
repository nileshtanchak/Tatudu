import 'package:flutter/material.dart';

import '../../widgets/custom_text_form_field.dart';
import '../../widgets/text_button.dart';
import '../../models/tudu.dart';
import '../../db_helper/db_helper.dart';
import '../../home/services/home_provider.dart';
import 'package:provider/provider.dart';

class AddTuduScreen extends StatefulWidget {
  final Tudu? tudu;
  final bool isEdit;

  const AddTuduScreen({Key? key, this.tudu, this.isEdit = false})
      : super(key: key);

  @override
  State<AddTuduScreen> createState() => _AddTuduScreenState();
}

class _AddTuduScreenState extends State<AddTuduScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    if (widget.tudu != null) {
      _nameController = TextEditingController(
        text: widget.tudu!.title,
      );
      _descController = TextEditingController(
        text: widget.tudu!.desc,
      );
    } else {
      _nameController = TextEditingController();
      _descController = TextEditingController();
    }
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
        title: Text(widget.isEdit ? "Edit Tudu" : "Add Tudu"),
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
          onTap: widget.isEdit ? _onUpdateTap : _onSaveTap,
          label: widget.isEdit ? "Update" : "Save",
        ),
      ),
    );
  }

  void _onSaveTap() async {
    Tudu tudu = Tudu(
      title: _nameController.text.trim(),
      desc: _descController.text.trim(),
    );
    if (await context.read<HomeProvider>().addTuduToDatabase(tudu)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Tudu added successfully"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _onUpdateTap() async {
    Tudu tudu = Tudu(
      id: widget.tudu!.id,
      title: _nameController.text.trim(),
      desc: _descController.text.trim(),
    );
    if (await context.read<HomeProvider>().updateTuduInDatabase(tudu)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Tudu updated successfully"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
