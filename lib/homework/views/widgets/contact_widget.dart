import 'package:flutter/material.dart';

import '../../models/contact.dart';
import 'contact_alert_dialog.dart';


class ContactsWidget extends StatelessWidget {
  final Contact contact;
  final Function(Contact contact) onEdit;
  final Function(int id) onDelete;

  const ContactsWidget({
    super.key,
    required this.contact,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.person,size: 30,),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    contact.number,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  final Contact? returnedContact = await showDialog(
                    context: context,
                    builder: (BuildContext context) => ContactAlertDialog(
                      contact: contact,
                      isSelected: false,
                    ),
                  );
                  if (returnedContact != null) {
                    onEdit(returnedContact);
                  }
                },
                icon: const Icon(Icons.edit,color: Colors.blue,),
              ),
              IconButton(
                onPressed: () {
                  onDelete(contact.id);
                },
                icon: const Icon(Icons.delete,color: Colors.red,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}