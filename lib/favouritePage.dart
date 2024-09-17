import 'package:flutter/material.dart';
import 'reviewpage.dart';
// implemented using pub.dev and labson widget
class MarkerInfo {
  final String id;
  final String title;
  final String snippet;

  MarkerInfo({required this.id, required this.title, required this.snippet});
}

class FavouritePage extends StatelessWidget {
  FavouritePage({super.key});

  final List<MarkerInfo> markerInfos = [
    MarkerInfo(
      id: "Raleigh Street Food Bank",
      title: "Raleigh Street Food Bank",
      snippet: "Open - Closes 16:30",
    ),
    MarkerInfo(
      id: "The Salvation Army",
      title: "The Salvation Army Food Bank/Charity",
      snippet: "Open Now",
    ),
    MarkerInfo(
      id: "Himmah Food bank",
      title: "Himmah Food Bank",
      snippet: "Opens Soon - 10am - 4pm",
    ),
  ];

  void _navigateToReviewPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        itemCount: markerInfos.length,
        itemBuilder: (context, index) {
          final markerInfo = markerInfos[index];
          return ListTile(
            leading: Icon(Icons.favorite, color: Colors.red), // Red heart icon
            title: Text(markerInfo.title),
            subtitle: Text(markerInfo.snippet),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToReviewPage(context),
        tooltip: 'Leave a Review',
        icon: const Icon(Icons.edit),
        label: const Text('Review'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
