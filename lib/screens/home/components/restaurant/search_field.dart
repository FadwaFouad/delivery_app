import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/data_provider.dart';

class SearchField extends ConsumerStatefulWidget {
  const SearchField({super.key});

  @override
  ConsumerState<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<SearchField> {
  final textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // change when search is empty
    textController.text = ref.watch(searchFoodProvider);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        controller: textController,
        focusNode: focusNode,
        onSubmitted: (value) =>
            ref.read(searchFoodProvider.notifier).state = value,
        decoration: InputDecoration(
          hintText: "Search for a dish",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                // clear text feild
                textController.clear();
                focusNode.unfocus();
                ref.read(searchFoodProvider.notifier).state = "";
              });
            },
            icon: Icon(
              Icons.close,
              size: 22,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
