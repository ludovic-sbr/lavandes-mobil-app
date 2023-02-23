import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function updateSearchParams;
  final TextEditingController searchParams;
  final String label;

  SearchBar(this.searchParams, this.updateSearchParams, this.label, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextField(
          controller: searchParams,
          onChanged: (val) => updateSearchParams(val),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: label,
          )),
    );
  }
}
