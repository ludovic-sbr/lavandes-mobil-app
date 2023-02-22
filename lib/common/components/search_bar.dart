import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function updateSearchParams;
  final TextEditingController searchParams;

  SearchBar(this.searchParams, this.updateSearchParams, {Key? key})
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
            hintText: 'Rechercher dans la liste...',
          )),
    );
  }
}
