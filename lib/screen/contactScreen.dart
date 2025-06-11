
import 'dart:developer';

import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../db/hiveManager.dart';
import '../model/local_contact.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<LocalContact> savedContacts = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init()async{
    savedContacts = HiveManager.getContacts();
    if (savedContacts.isEmpty) {
      log('Contacts not found------------->>   ');
      await fetchAndSaveContacts();
    }else{
     var contact= getContactByPartialNumber('9198483660');
      log('Contacts found------------->>  ${contact.phone} ${contact.name}');
    }
  }

  Future<void> fetchAndSaveContacts() async {
    final status = await Permission.contacts.request();
    if (status.isGranted) {

      final contacts = await FastContacts.getAllContacts();
      for (final contact in contacts) {
        if (contact.phones != null && contact.phones.isNotEmpty) {
          final newContact = LocalContact(
            name: contact.displayName ?? 'Unknown',
            phone: contact.phones.first.number,
          );
          await HiveManager.saveContact(newContact);
        }
        log('Contact saved: ${contact.displayName}');
      }
      setState(() {
        savedContacts = HiveManager.getContacts();
      });
    } else {
      log("Permission denied");
    }
  }

  LocalContact getContactByPartialNumber(String number) {
    String normalize(String s) => s.replaceAll(RegExp(r'\D'), '');
    return savedContacts.firstWhere(
          (c) => normalize(c.phone).contains(normalize(number)),
      orElse: () => LocalContact(name: 'Unknown', phone: 'Unknown'),
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stored Contacts')),
      body: ListView.builder(
        itemCount: savedContacts.length,
        itemBuilder: (context, index) {
          final contact = savedContacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
          );
        },
      ),
    );
  }
}