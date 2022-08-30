import 'package:flutter/material.dart';
import '../../core/size_config.dart';

import '../../core/my_colors.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    Key? key,
    required this.noteTitile,
    required this.noteBody,
  }) : super(key: key);

  final String noteTitile;
  final String noteBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Container(
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: white.withOpacity(0.1))),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noteTitile,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    noteBody,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      color: white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
