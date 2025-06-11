import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/asyncNotifyProvider.dart';
import '../provider/futureProvider.dart';
import '../provider/notifyProvider.dart';
import '../provider/provider.dart';
import '../provider/streamNotifiyProvider.dart';
import '../provider/streamProvider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,) {
    log('build');
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
            builder: (context, data, child) {
            return Text(data.watch(appNameProvider),style: TextStyle(color: Colors.white),);
          }
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Consumer(
        builder: (context, data, child) {
          log('consumer');
          return Center(child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${data.watch(counterProvider)}'),
                SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      log('button');
                      data.read(counterProvider.notifier).increment();
                    }, child: Text('Increment')),
                    SizedBox(width: 20,),
                    ElevatedButton(onPressed: (){
                      log('button');
                      data.read(counterProvider.notifier).decrement();
                    }, child: Text('Decrement')),
                  ],
                ),
                SizedBox(height: 20,),
                Text(data.watch(userProvider).when(
                  data: (data) => data,
                  error: (error, stackTrace) => error.toString(),
                  loading: () => 'Loading...',
                )),
                SizedBox(height: 20,),
                Text(data.watch(clockProvider).when(
                  data: (data) => data.toString(),
                  error: (error, stackTrace) => error.toString(),
                  loading: () => 'Loading...',
                )),
                SizedBox(height: 20,),
                Container(padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  onChanged: (value) {
                    data.read(nameNotifierProvider.notifier).changeName(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    border: OutlineInputBorder(),
                  ),
                ),),
                SizedBox(height: 20,),
                Text(data.watch(nameNotifierProvider).when(
                  skipLoadingOnReload: true,
                  data: (data) => data,
                  error: (error, stackTrace) => error.toString(),
                  loading: () => 'Loading...',
                )),
                SizedBox(height: 20,),

                Text(data.watch(timerProvider).when(
                  data: (data) => data.toString(),
                  error: (error, stackTrace) => error.toString(),
                  loading: () => 'Loading...',
                )),
                SizedBox(height: 20,),
              ],
            ),
          ),);
        }
      ),
    );
  }
}
