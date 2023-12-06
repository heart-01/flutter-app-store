import 'package:flutter/material.dart';

class CounterStatefulScreen extends StatefulWidget {
  const CounterStatefulScreen({super.key});

  @override
  State<CounterStatefulScreen> createState() => _CounterStatefulScreenState();
}

class _CounterStatefulScreenState extends State<CounterStatefulScreen> {
  int couter = 0;

  void couterUp() {
    setState(() {
      couter++;
    });
  }

  void couterDown() {
    setState(() {
      couter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stateful ${DateTime.now().microsecondsSinceEpoch}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: couterUp,
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.blue,
              ),
            ),
            Text(
              couter.toString(),
              style: const TextStyle(fontSize: 120),
            ),
            IconButton(
              onPressed: couterDown,
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
              ),
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
    );
  }
}
