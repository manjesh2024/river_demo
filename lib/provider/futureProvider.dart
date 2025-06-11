import 'package:riverpod/riverpod.dart';

final userProvider = FutureProvider<String>((ref) async {
  await Future.delayed(Duration(seconds: 5));
  return 'Manjesh';
});
