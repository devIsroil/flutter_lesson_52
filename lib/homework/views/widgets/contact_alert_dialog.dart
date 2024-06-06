
import 'package:flutter/material.dart';

import '../../models/contact.dart';
import 'custom_text_field.dart';

class ContactAlertDialog extends StatelessWidget {
  final Contact contact;
  final bool isSelected;

  ContactAlertDialog({
    super.key,
    required this.contact,
    required this.isSelected,
  });

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(isSelected ? 'Add contact' : 'Edit contact'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            initialValue: contact.name,
            controller: _nameController,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter valid name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          CustomTextField(
            initialValue: contact.number,
            controller: _numberController,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter valid number';
              }
              return null;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
              Contact(
                id: contact.id,
                name: _nameController.text,
                number: _numberController.text,
              ),
            );
          },
          child: const Text('save'),
        ),
      ],
    );
  }
}