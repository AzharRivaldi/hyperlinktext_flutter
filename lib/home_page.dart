import 'package:flutter/material.dart';
import 'package:hyperlink_text/tools.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String rawText = '''Here is a sample test http://example.com (https://example.com)
  Contact: mailto:example@example.com and tel:+1-555-5555-555
  https://example.com''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: const Text(
          "Hyperlink Text",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                  children: Linkifytext.linkifytext(rawText),
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black
                  )
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            RichText(
                text: Linkify.linkify(context, rawText)
            )
          ],
        ),
      ),
    );
  }
}
