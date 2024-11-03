import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GithubRepositorySearchPage extends ConsumerWidget {
  const GithubRepositorySearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
            viewBackgroundColor: theme.scaffoldBackgroundColor,
            builder: (context, controller) {
              return SearchBar(
                controller: controller,
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: const Icon(Icons.search),
              );
            },
            suggestionsBuilder: (context, controller) {
              return List<ListTile>.generate(5, (int index) {
                final item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    // setState(() {
                    //   controller.closeView(item);
                    // });
                  },
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
