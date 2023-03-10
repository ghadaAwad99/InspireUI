import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../models/story.dart';

class StoryText extends Text {
  StoryText(
    StoryContent content, {
    Key? key,
  }) : super(
          content.getTitle()!,
          key: key,
          textAlign: content.typography!.convertStringToAlign(),
          // style: GoogleFonts.getFont(
          //   content.typography!.font!,
          //   textStyle: TextStyle(
          //     fontFamily: content.typography?.font?.isNotEmpty == true
          //         ? content.typography?.font
          //         : 'Roboto',
          //     fontSize: content.typography?.fontSize ?? 15,
          //     fontStyle: content.typography?.convertStringToStyle() ??
          //         FontStyle.normal,
          //   ),
          //   fontWeight: content.typography?.convertStringToWeight() ??
          //       FontWeight.normal,
          //   decoration: content.typography?.convertStringToDecoration() ??
          //       TextDecoration.none,
          //   color: Colors.white,
          // ),
        );
}
