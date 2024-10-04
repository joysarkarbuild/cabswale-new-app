import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key, required this.onChanged});
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        onChanged: (value) {
          onChanged(value);
        },
        decoration: const InputDecoration(
          hintText: 'Search...',
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
