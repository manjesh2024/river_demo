import 'package:riverpod/riverpod.dart';

class TimerNotifier extends StreamNotifier<int> {
  @override
  Stream<int> build() async* {
    int count = 0;
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield count++;
    }
  }
}

final timerProvider =
StreamNotifierProvider<TimerNotifier, int>(() => TimerNotifier());
