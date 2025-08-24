import 'package:flutter/material.dart';
import 'rb_item.dart';

class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    // Get item from route arguments (standard way with pushNamed)
    final RBItem? item = ModalRoute.of(context)?.settings.arguments as RBItem?;

    if (item == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Item Details'),
        ),
        body: const Center(
          child: Text('No item data available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 64,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            
            // Asset Description
            Text(
              item.assetDescription,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Location
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.formattedLocation,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Event Name
            Row(
              children: [
                const Icon(Icons.event, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.eventAdvertisedName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Event Date
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  item.formattedEventDate,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            
            // Item Number (if available)
            if (item.itemNumber != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.tag, color: Colors.purple),
                  const SizedBox(width: 8),
                  Text(
                    'Item #${item.itemNumber}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}