import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'rb_item.dart';
import 'rb_item_details_view.dart';
import 'rb_api_service.dart';

class RBItemListView extends StatefulWidget {
  const RBItemListView({super.key});

  static const routeName = '/';

  @override
  State<RBItemListView> createState() => _RBItemListViewState();
}

class _RBItemListViewState extends State<RBItemListView> {
  List<RBItem> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    try {
      final fetchedItems = await RBApiService.fetchItems(size: 10);
      setState(() {
        items = fetchedItems;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('RB Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
            title: Text(item.assetDescription),
            subtitle: Text('${item.formattedLocation} • ${item.eventAdvertisedName}'),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(item.imageUrl),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                SampleItemDetailsView.routeName,
                arguments: item,
              );
            }
          );
        },
      ),
    );
  }
}
