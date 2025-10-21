import 'package:flutter/material.dart';
// import '/l10n/localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.run_circle)),
      body: SizedBox.expand(
        child: Column(
          children: [
            Container(color: Colors.blue, height: 300),
            Expanded(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 40,
                    childAspectRatio: 2,
                  ),
                  itemCount: 20,
                  itemBuilder: (context, index) => Container(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
