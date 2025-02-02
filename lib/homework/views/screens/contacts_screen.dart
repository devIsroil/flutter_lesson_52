import 'package:flutter/material.dart';

import '../../models/contact.dart';
import '../../services/contact_database.dart';
import '../widgets/contact_alert_dialog.dart';
import '../widgets/contact_widget.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final ContactDatabase _contactDatabase = ContactDatabase.instance;

  void editContact({required Contact contact}) async {
    await _contactDatabase.editContact(
      id: contact.id,
      newName: contact.name,
      newNumber: contact.number,
    );
    setState(() {});
  }

  void deleteContact({required int id}) async {
    await _contactDatabase.deleteContact(id: id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Contacts',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () async {
                  final Contact? returnedContact = await showDialog(
                    context: context,
                    builder: (BuildContext context) => ContactAlertDialog(
                      contact: Contact(id: 0, name: '', number: ''),
                      isSelected: true,
                    ),
                  );
                  if (returnedContact != null) {
                   // print('added');
                    ContactDatabase.instance
                        .addContact(
                          name: returnedContact.name,
                          number: returnedContact.number,
                        )
                        .then(
                          (value) => setState(() {}),
                        );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _contactDatabase.getContacts(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Contact>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(
                    child: Text('Error loading contacts'),
                  );
                } else {
                  List<Contact> contacts = snapshot.data!;
                  contacts
                      .sort((Contact a, Contact b) => a.name.compareTo(b.name));
                  return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ContactsWidget(
                        contact: contacts[index],
                        onEdit: (Contact updatedContact) {
                          editContact(contact: updatedContact);
                        },
                        onDelete: (int id) {
                          deleteContact(id: id);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
