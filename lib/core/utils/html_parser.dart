// import 'package:flutter/material.dart';
// import 'package:html/parser.dart';
//
// abstract class HtmlParser{
//   static String skipHtml(String? htmlString) {
//     try {
//       var document = parse(htmlString);
//       return parse(document.body!.text).documentElement!.text;
//     } catch (_) {
//       return '';
//     }
//   }
//
//   static String applyHtml(context, String? html, {TextStyle? style}) {
//     try {
//       return parse(html ?? '').body!.text;
//     } catch (_) {
//       return '';
//     }
//   }
//
// }
