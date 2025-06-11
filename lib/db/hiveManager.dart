import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../adapter/localContactAdaptert.dart';
import '../model/local_contact.dart';

class HiveManager {
  static const String contactBoxName = 'contacts';

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
    Hive.registerAdapter(LocalContactAdapter());
    await Hive.openBox<LocalContact>(contactBoxName);
  }

  static Box<LocalContact> get contactBox => Hive.box<LocalContact>(contactBoxName);

  static Future<void> saveContact(LocalContact contact) async {
    await contactBox.add(contact);
  }

  static List<LocalContact> getContacts() {
    return contactBox.values.toList();
  }
}