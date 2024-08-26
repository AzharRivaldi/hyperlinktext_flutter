import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//only url
class Linkifytext {
  static List<TextSpan> linkifytext(String rawString) {
    List<TextSpan> textSpan = [];

    final urlRegExp = RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?"
    );

    getLink(String linkString) {
      textSpan.add(
        TextSpan(
          text: linkString,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launchUrl(Uri.parse(linkString));
            },
        ),
      );
      return linkString;
    }

    getNormalText(String normalText) {
      textSpan.add(
        TextSpan(
          text: normalText,
          style: const TextStyle(color: Colors.black),
        ),
      );
      return normalText;
    }

    rawString.splitMapJoin(
      urlRegExp,
      onMatch: (m) => getLink("${m.group(0)}"),
      onNonMatch: (n) => getNormalText(n.substring(0)),
    );

    return textSpan;
  }
}

//with no telp richtext only
class Linkify {
  static TextSpan linkify(BuildContext context, String rawText) {
    final spans =
    rawText.split(RegExp('(?=https?://|mailto:|tel:)')).indexed.expand((e) {
      final (i, chunk) = e;
      final index = i == 0 ? 0 : chunk.indexOf(RegExp('\\s|\\)|\$'));
      final link = chunk.substring(0, index);
      return [
        if (i != 0)
          TextSpan(
            text: link.replaceFirst(RegExp('^(mailto|tel):'), ''),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => launchUrl(Uri.parse(link)),
          ),
        TextSpan(
          text: chunk.substring(index),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ];
    });
    return TextSpan(children: [...spans]);
  }
}