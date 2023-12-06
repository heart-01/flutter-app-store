import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLayoutGridView = true;

  void handleOnClickChangeLayoutView() {
    setState(() {
      isLayoutGridView = !isLayoutGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: handleOnClickChangeLayoutView,
          icon: Icon(isLayoutGridView ? Icons.list_outlined : Icons.grid_view),
        ),
        title: const Text('สินค้า'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: isLayoutGridView ? layoutGridView() : layoutListView(),
    );
  }

  // layout gridView Widget
  Widget layoutGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2 // Number of column
          ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // layout listView Widget
  Widget layoutListView() {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: SizedBox(
            height: 350,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
