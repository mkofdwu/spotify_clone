import 'package:flutter/material.dart';

class SongTag extends StatelessWidget {
  final String tag;

  const SongTag({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: Color(0xFF9e9e9e),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        tag.toUpperCase(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
