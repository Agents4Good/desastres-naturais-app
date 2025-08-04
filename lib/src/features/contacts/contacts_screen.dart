// ignore_for_file: use_build_context_synchronously

import 'package:aguas_da_borborema/src/features/contacts/address_screen.dart';
import 'package:aguas_da_borborema/src/services/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aguas_da_borborema/l10n/app_localizations.dart';

import '../../services/location_service.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];
  bool loading = false;

  void getContacts() async {
    setState(() => loading = true);
    contacts = await contactService.getContacts();
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.contactsTitle),
        backgroundColor: const Color(0xFF0b2351),
      ),
      body: contacts.isEmpty
          ? Center(child: Text(l10n.contactsEmptyMessage))
          : Column(
              children: contacts.map((c) {
                return ListTile(
                  title: Text(c.name),
                  subtitle: Text(c.address),
                  trailing: PopupMenuButton(itemBuilder: (_) {
                    return [
                      PopupMenuItem(
                        child: Text(l10n.contactsEdit),
                        onTap: () async {
                          final updated = await showDialog<bool>(
                            context: context,
                            builder: (_) => UpdateContact(contact: c),
                          );
                          if (updated == true) getContacts();
                        },
                      ),
                      PopupMenuItem(
                        child: Text(l10n.contactsDelete),
                        onTap: () async {
                          final deleted = await showDialog<bool>(
                            context: context,
                            builder: (_) => DeleteContact(id: c.id!),
                          );
                          if (deleted == true) getContacts();
                        },
                      ),
                    ];
                  }),
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final added = await showDialog<bool>(
            context: context,
            builder: (_) => const AddContact(),
          );
          if (added == true) getContacts();
        },
        child: const Icon(Icons.add),
        tooltip: l10n.addContactLabelName,
      ),
    );
  }
}

class DeleteContact extends StatelessWidget {
  final int id;
  const DeleteContact({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      content: Text(l10n.deleteContactConfirmation),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(l10n.buttonCancel),
        ),
        FilledButton(
          onPressed: () async {
            await contactService.delete(id);
            context.pop(true);
          },
          child: Text(l10n.modelDelete),
        ),
      ],
    );
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
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController(text: contact.name);
    final addressController = TextEditingController(text: contact.address);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(label: Text(l10n.updateContactLabelName)),
            controller: nameController,
            onChanged: (v) => contact.name = v,
          ),
          TextField(
            decoration: InputDecoration(label: Text(l10n.updateContactLabelAddress)),
            controller: addressController,
            onChanged: (v) => contact.address = v,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(l10n.buttonCancel),
        ),
        FilledButton(
          onPressed: () async {
            setState(() => loading = true);
            await contactService.update(contact);
            setState(() => loading = false);
            context.pop(true);
          },
          child: Text(l10n.buttonSave),
        ),
      ],
    );
  }
}

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String name = "";
  Location? location;
  bool loading = false;
  final locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(label: Text(l10n.addContactLabelName)),
            onChanged: (v) => name = v,
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DebouncedSearchBar<Location>(
              onResultSelected: (result) => location = result,
              searchFunction: (q) => locationService.searchLocation(q),
              titleBuilder: (r) => Text(r.address),
              hintText: l10n.addContactHintLocation,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(l10n.buttonCancel),
        ),
        FilledButton(
          onPressed: () async {
            setState(() => loading = true);
            final c = Contact(
              name: name,
              address: location!.address,
              latitude: location!.latitude,
              longitude: location!.longitude,
            );
            await contactService.insert(c);
            setState(() => loading = false);
            context.pop(true);
          },
          child: Text(l10n.buttonSave),
        ),
      ],
    );
  }
}
