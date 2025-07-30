// ignore_for_file: use_build_context_synchronously

import 'package:aguas_da_borborema/src/services/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];
  bool loading = false;

  void getContacts() async {
    setState(() {
      loading = true;
    });
    contacts = await contactService.getContacts();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos Salvos'),
        backgroundColor: const Color(0xFF0b2351),
      ),
      body: contacts.isEmpty
          ? const Center(child: Text("Adicione um novo contato."))
          : Column(
              children: contacts
                  .map((c) => ListTile(
                        title: Text(c.name),
                        subtitle: Text(c.address),
                        trailing: PopupMenuButton(itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: const Text("Editar"),
                              onTap: () async {
                                var addStatus = await showDialog(
                                    context: context,
                                    builder: (builder) =>
                                        UpdateContact(contact: c));
                                if (addStatus == true) {
                                  getContacts();
                                }
                              },
                            ),
                            PopupMenuItem(
                              child: const Text("Excluir"),
                              onTap: () async {
                                var addStatus = await showDialog(
                                    context: context,
                                    builder: (builder) =>
                                        DeleteContact(id: c.id!));
                                if (addStatus == true) {
                                  getContacts();
                                }
                              },
                            )
                          ];
                        }),
                      ))
                  .toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var addStatus = await showDialog(
              context: context, builder: (builder) => const AddContact());
          if (addStatus == true) {
            getContacts();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DeleteContact extends StatelessWidget {
  final int id;
  const DeleteContact({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content:
            const Text("Você tem certeza de que deseja excluir este contato?"),
        actions: [
          TextButton(
              onPressed: () async {
                context.pop();
              },
              child: const Text("Cancelar")),
          FilledButton(
              onPressed: () async {
                await contactService.delete(id);
                context.pop(true);
              },
              child: const Text("Salvar")),
        ]);
  }
}

class UpdateContact extends StatefulWidget {
  final Contact contact;
  const UpdateContact({super.key, required this.contact});

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  bool loading = false;
  late Contact contact;

  @override
  void initState() {
    super.initState();
    contact = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(label: Text("Nome")),
              controller: TextEditingController(text: contact.name),
              onChanged: (value) {
                contact.name = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(label: Text("Endereço")),
              controller: TextEditingController(text: contact.address),
              onChanged: (value) {
                contact.address = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () async {
                context.pop();
              },
              child: const Text("Cancelar")),
          FilledButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await contactService.update(contact);
                setState(() {
                  loading = false;
                });
                context.pop(true);
              },
              child: const Text("Salvar")),
        ]);
  }
}

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String name = "";
  String address = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(label: Text("Nome")),
              onChanged: (value) {
                name = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(label: Text("Endereço")),
              onChanged: (value) {
                address = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () async {
                context.pop();
              },
              child: const Text("Cancelar")),
          FilledButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                Contact contact = Contact(name: name, address: address);
                await contactService.insert(contact);
                setState(() {
                  loading = false;
                });
                context.pop(true);
              },
              child: const Text("Salvar")),
        ]);
  }
}
