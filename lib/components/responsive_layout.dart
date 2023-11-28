import 'package:flutter/material.dart';
import 'package:flutter_store/themes/colors.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webChild;
  final Widget mobileChild;

  const ResponsiveLayout({
    Key? key,
    required this.webChild,
    required this.mobileChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryDark, primary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                // Using for responsive layout
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    // If the width of screen is more than 800 then show webChild
                    if (constraints.maxWidth > 800) {
                      return webChild;
                    }
                    return mobileChild;
                  },
                )),
          ),
        ),
      ),
    );
  }
}
