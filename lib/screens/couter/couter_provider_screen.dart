import 'package:flutter/material.dart';
import 'package:flutter_store/providers/counter_provider.dart';
import 'package:flutter_store/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class CounterProviderScreen extends StatelessWidget {
  const CounterProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load Provider when not initialized in main.dart
    // final counterProvider = Provider.of<CounterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${DateTime.now().microsecondsSinceEpoch}'),
        actions: [
          Consumer<TimerProvider>(  // Consumer is used to get data from provider
            builder: (context, provider, child) {
              return TextButton(
                onPressed: () {},
                child: Text(
                  provider.seconds.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(  // Consumer is used to get data from provider
              builder: (context, provider, child) {
                return Column(
                  children: [
                    IconButton(
                      onPressed:
                          provider.counterUp, // call function from provider
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      provider.count.toString(), // get count from provider
                      style: const TextStyle(fontSize: 120),
                    ),
                    IconButton(
                      onPressed:
                          provider.counterDown, // call function from provider
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              'Open at : ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Timestamp : ${DateTime.now().microsecondsSinceEpoch.toString()}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<TimerProvider>(
        builder: (context, provider, child) {
          return FloatingActionButton(
            onPressed: provider.isRunning ? provider.stopTimer : provider.startTimer,
            child: Icon(provider.isRunning ? Icons.pause : Icons.play_arrow),
          );
        },
      ),
    );
  }
}
