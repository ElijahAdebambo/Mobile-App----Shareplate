import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

//implemented using labs on maps

class FoodbankPage extends StatefulWidget {
  const FoodbankPage({Key? key}) : super(key: key);

  @override
  _FoodbankPageState createState() => _FoodbankPageState();
}

class _FoodbankPageState extends State<FoodbankPage> {
  final List<Marker> _markers = [];
  late GoogleMapController _mapController;
  final LatLng _center = const LatLng(52.912022, -1.185679);
  Map<String, bool> _isFavoriteMap = {};
  List<String> _favoritedItems = [];

  @override
  void initState() {
    super.initState();
    Permission.locationWhenInUse.request();
    _addMarkersToMap();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
  }

  void _addMarkersToMap() {
    final markers = [
      Marker(
        markerId: MarkerId("The Trussell Trust Food Bank"),
        position: LatLng(52.93518604648199, -1.2153858710846808),
        infoWindow: InfoWindow(
          title: "The Trussell Trust Food Bank",
          snippet: "Open - Closes 16:30",
        ),
      ),
      Marker(
        markerId: MarkerId("Raleigh Street Food Bank"),
        position: LatLng(52.96062563088398, -1.161368609715679),
        infoWindow: InfoWindow(
          title: "Raleigh Street Food Bank",
          snippet: "Open - Closes 16:30",
        ),
      ),
      Marker(
        markerId: MarkerId("The Salvation Army"),
        position: LatLng(52.95285264283401, -1.1320512245071233),
        infoWindow: InfoWindow(
          title: "The Salvation Army Food Bank/Charity",
          snippet: "Open Now",
        ),
      ),
      Marker(
        markerId: MarkerId("Himmah Food bank"),
        position: LatLng(52.960032434066086, -1.167091585876107),
        infoWindow: InfoWindow(
          title: "Himmah Food Bank",
          snippet: "Opens Soon - 10am - 4pm",
        ),
      ),
      Marker(
        markerId: MarkerId("Rushcliffe Foodbank"),
        position: LatLng(52.91239219303965, -1.1121861483466953),
        infoWindow: InfoWindow(
          title: "Rushcliffe Food Bank/Church",
          snippet: "Closed Now - Opens Saturday, 9–11:30am",
        ),
      ),
      Marker(
        markerId: MarkerId("Remar Nottingham Community Kitchen Foodbank"),
        position: LatLng(52.91239219303965, -1.1121861483466953),
        infoWindow: InfoWindow(
          title: "Remar Nottingham Community Food Bank/Kitchen",
          snippet: "Opens 9–11:30am",
        ),
      ),
      Marker(
        markerId: MarkerId("Arnold Foodbank - part of The Trussell Trust network"),
        position: LatLng(52.99717019587135, -1.1370097790311873),
        infoWindow: InfoWindow(
          title: "Arnold Food Bank/Church",
          snippet: "Closed Today",
        ),
      ),
      Marker(
        markerId: MarkerId("The Trussell Trust Food Bank - again"),
        position: LatLng(52.920405491146155, -1.16809911153297),
        infoWindow: InfoWindow(
          title: "The Trussell Trust Food Bank",
          snippet: "Open Now",
        ),
      ),
      Marker(
        markerId: MarkerId("The Trussell Trust Food Bank/Church - different location"),
        position: LatLng(53.01546843695631, -1.161853611334926),
        infoWindow: InfoWindow(
          title: "The Trussell Trust Food Bank/Church",
          snippet: "Closed - Opens 1pm",
        ),
      ),
      Marker(
        markerId: MarkerId("Arena Community Foodbank"),
        position: LatLng(52.984742891663835, -1.3027948338169524),
        infoWindow: InfoWindow(
          title: "Arena Community Food Bank",
          snippet: "Opens Soon - 10am",
        ),
      ),
    ];

    setState(() {
      _markers.addAll(markers);
      // Initialize all markers as not favorite.
      for (var marker in markers) {
        _isFavoriteMap[marker.markerId.value] = false;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Foodbank's Nottingham"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              myLocationEnabled: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
              ),
              markers: _markers.toSet(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _markers.length,
              itemBuilder: (context, index) {
                final marker = _markers[index];
                return _buildListTile(marker.infoWindow.title!, marker.infoWindow.snippet!, marker.markerId.value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, String snippet, String markerId) {
    return ListTile(
      leading: Icon(Icons.location_on),
      title: Text(title),
      subtitle: Text(snippet),
      trailing: IconButton(
        icon: Icon(
          _isFavoriteMap[markerId]! ? Icons.favorite : Icons.favorite_border,
          color: _isFavoriteMap[markerId]! ? Colors.red : null,
        ),
        onPressed: () {
          // Updates the favorite status of the marker on clivk
          setState(() {
            _isFavoriteMap[markerId] = !_isFavoriteMap[markerId]!;
            if (_isFavoriteMap[markerId]!) {
              _favoritedItems.add(title);
            } else {
              _favoritedItems.remove(title);
            }
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
