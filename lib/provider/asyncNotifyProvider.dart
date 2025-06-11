import 'package:riverpod/riverpod.dart';

class NameNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    await Future.delayed(Duration(milliseconds: 500));
    return "Async Name";
  }

  Future<void> changeName(String newName) async {
    state = const AsyncValue.loading();
    await Future.delayed(Duration(milliseconds: 300));
    state = AsyncValue.data(newName);
  }
}

final nameNotifierProvider =
AsyncNotifierProvider<NameNotifier, String>(() => NameNotifier());
